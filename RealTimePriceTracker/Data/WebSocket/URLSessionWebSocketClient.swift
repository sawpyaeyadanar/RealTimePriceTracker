import Foundation
import Combine

public final class URLSessionWebSocketClient: WebSocketClient {
    private let url: URL
    private let session: URLSession
    private var task: URLSessionWebSocketTask?
    
    private let incomingSubject = PassthroughSubject<String, Never>()
    private let stateSubject = CurrentValueSubject<ConnectionState, Never>(.disconnected)
    
    public var incomingText: AnyPublisher<String, Never> {
        incomingSubject.eraseToAnyPublisher()
    }
    
    public var state: AnyPublisher<ConnectionState, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    init(url: URL, session: URLSession, task: URLSessionWebSocketTask? = nil) {
        self.url = url
        self.session = session
        self.task = task
    }
    
    public func connect() {
        guard task == nil else { return }
        stateSubject.send(.connecting)
        let t = session.webSocketTask(with: url)
        task = t
        t.resume()
        stateSubject.send(.connected)
        receiveLoop()
    }
    
    public func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        stateSubject.send(.disconnected)
    }
    
    public func send(text: String) {
        guard let task else { return }
        task.send(.string(text)) { [weak self] error in
            guard let self else { return }
            if let error {
                self.stateSubject.send(.failed(error.localizedDescription))
                print(error.localizedDescription)
            }
        }
    }
    
    private func receiveLoop() {
        guard let task else { return }
        task.receive { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let message):
                if case .string(let text) = message {
                    self.incomingSubject.send(text)
                }
                self.receiveLoop()
            case .failure(let failure):
                self.stateSubject.send(.failed(failure.localizedDescription))
                self.disconnect()
            }
        }
    }
    
}

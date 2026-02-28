import Foundation
import Combine

public final class WebSocketPriceStreamingRepository {
    public let client: WebSocketClient
    private let tickSubject = PassthroughSubject<PriceTick, Never>()
    public var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?
    private let generator: PriceGenerating
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    public var connectionState: AnyPublisher<ConnectionState, Never> {
        client.state
    }
    public var ticks: AnyPublisher<PriceTick, Never> {
        tickSubject.eraseToAnyPublisher()
    }
    
    init(client: WebSocketClient, generator: PriceGenerating) {
        self.client = client
        self.generator = generator
        client.incomingText
            .compactMap{ [weak self] text -> PriceTick? in
                guard let self else { return nil}
                guard let data = text.data(using: .utf8) else { return nil }
                return try? self.decoder.decode(PriceTick.self, from: data)
            }
            .sink { [weak self] tick in
                self?.tickSubject.send(tick)
            }
            .store(in: &cancellables)
    }
}

extension WebSocketPriceStreamingRepository: PriceStreamingRepository {
    public func connect() {
        client.connect()
    }
    
    public func disconnect() {
        client.disconnect()
    }
    
    public func startSendingTicks(symbols: [String]) {
        stopSendingTicks()
        timerCancellable = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }
                let now = Date().timeIntervalSince1970
                for symbol in symbols {
                    let tick = PriceTick(symbol: symbol, price: self.generator.nextPrice(), ts: now)
                    guard let data = try? self.encoder.encode(tick),
                          let text = String(data: data, encoding: .utf8) else {
                        continue
                    }
                    self.client.send(text: text)
                }
            })
    }
    
    public func stopSendingTicks() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    
}

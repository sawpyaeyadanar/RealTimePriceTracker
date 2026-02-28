import Combine
public protocol WebSocketClient {
    var incomingText: AnyPublisher<String, Never> { get }
    var state: AnyPublisher<ConnectionState, Never> { get }
    
    func connect()
    func disconnect()
    func send(text: String)
}

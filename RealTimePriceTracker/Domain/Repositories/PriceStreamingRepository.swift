import Combine


public enum ConnectionState: Equatable {
    case disconnected
    case connecting
    case connected
    case failed(String)
}

public protocol PriceStreamingRepository {
    var connectionState: AnyPublisher<ConnectionState, Never> { get }
    var ticks: AnyPublisher<PriceTick, Never> { get }
    
    func connect()
    func disconnect()
    func startSendingTicks(symbols: [String])
    func stopSendingTicks()
}

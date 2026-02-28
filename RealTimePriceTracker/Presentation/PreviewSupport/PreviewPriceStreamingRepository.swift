import Combine

final class PreviewPriceStreamingRepository: PriceStreamingRepository {
    var state: ConnectionState = .connected
    var connectionState: AnyPublisher<ConnectionState, Never> { Just(state).eraseToAnyPublisher() }
    var ticks: AnyPublisher<PriceTick, Never> { Empty().eraseToAnyPublisher() }

    func connect() {}
    func disconnect() {}
    func startSendingTicks(symbols: [String]) {}
    func stopSendingTicks() {}
}

struct PreviewStartUseCase: StartStreamingUseCase {
    func execute(symbols: [String]) {}
}

struct PreviewStopUseCase: StopStreamingUseCase {
    func execute() {}
}

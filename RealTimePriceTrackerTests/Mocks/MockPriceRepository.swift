import XCTest
import Combine
@testable import RealTimePriceTracker

final class MockPriceRepository: PriceStreamingRepository {
    
    let connectionStateSubject = PassthroughSubject<ConnectionState, Never>()
    let ticksSubject = PassthroughSubject<PriceTick, Never>()

    var connectionState: AnyPublisher<ConnectionState, Never> {
        connectionStateSubject.eraseToAnyPublisher()
    }

    var ticks: AnyPublisher<PriceTick, Never> {
        ticksSubject.eraseToAnyPublisher()
    }

    private(set) var didConnect = false
    private(set) var didDisconnect = false
    private(set) var startedSymbols: [String] = []
    private(set) var didStopSending = false

    func connect() {
        didConnect = true
    }
    
    func disconnect() {
        didDisconnect = true
    }
    
    func startSendingTicks(symbols: [String]) {
        startedSymbols = symbols
    }
    
    func stopSendingTicks() {
        didStopSending = true
    }
}

final class MockStartStreamingUseCase: StartStreamingUseCase {
    private(set) var executedSymbols: [String] = []
    
    func execute(symbols: [String]) {
        executedSymbols = symbols
    }
}

final class MockStopStreamingUseCase: StopStreamingUseCase {
    private(set) var executed = false
    
    func execute() { 
        executed = true
    }
}

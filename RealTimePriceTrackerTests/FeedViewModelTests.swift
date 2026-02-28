import XCTest
import Combine
@testable import RealTimePriceTracker

@MainActor
final class FeedViewModelTests: XCTestCase {
    
    //toggleStart test
    func test_toggleStart_callsStartUseCase_andSetsRunningTrue() {
        let repo = MockPriceRepository()
        let start = MockStartStreamingUseCase()
        let stop = MockStopStreamingUseCase()

        let initial: [Stock] = [
            Stock(symbol: "AAPL", description: "Apple", price: 100, previousPrice: 0),
            Stock(symbol: "TSLA", description: "Tesla", price: 90, previousPrice: 0)
        ]

        let vm = FeedViewModel(stocks: initial, startUseCase: start, stopUseCase: stop, repo: repo)

        vm.toggle()

        XCTAssertTrue(vm.isRunning)
        XCTAssertEqual(start.executedSymbols.sorted(), ["AAPL", "TSLA"])
    }

    //tickUpdates test
    func test_tickUpdatesPrice_andSortsDescending() {
        let repo = MockPriceRepository()
        let start = MockStartStreamingUseCase()
        let stop = MockStopStreamingUseCase()

        let initial: [Stock] = [
            Stock(symbol: "AAPL", description: "Apple", price: 100, previousPrice: 0),
            Stock(symbol: "TSLA", description: "Tesla", price: 200, previousPrice: 0)
        ]

        let vm = FeedViewModel(stocks: initial, startUseCase: start, stopUseCase: stop, repo: repo)

        repo.ticksSubject.send(PriceTick(symbol: "AAPL", price: 300, ts: 0))

        XCTAssertEqual(vm.stocks.first?.symbol, "AAPL")
        XCTAssertEqual(vm.stocks.first?.price ?? 0.0, 300, accuracy: 0.0001)
    }

    //connectionState test
    func test_connectionState_isPublishedToViewModel() {
        let repo = MockPriceRepository()
        let start = MockStartStreamingUseCase()
        let stop = MockStopStreamingUseCase()

        let vm = FeedViewModel(
            stocks: [Stock(symbol: "AAPL", description: "Apple", price: 100, previousPrice: 0)],
            startUseCase: start,
            stopUseCase: stop,
            repo: repo
        )

        repo.connectionStateSubject.send(.connected)

        XCTAssertEqual(vm.connectionState, .connected)
    }
}

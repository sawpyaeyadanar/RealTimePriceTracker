import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published private(set) var stocks: [Stock] = []
    @Published private(set) var connectionState: ConnectionState = .disconnected
    @Published private(set) var isRunning: Bool = false
    
    private let startUseCase: StartStreamingUseCase
    private let stopUseCase: StopStreamingUseCase
    private let repo: PriceStreamingRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(stocks: [Stock], startUseCase: StartStreamingUseCase, stopUseCase: StopStreamingUseCase, repo: PriceStreamingRepository) {
        self.stocks = stocks
        self.startUseCase = startUseCase
        self.stopUseCase = stopUseCase
        self.repo = repo
        bind()
    }
    
    private func bind() {
        repo.connectionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.connectionState = state
            }
            .store(in: &cancellables)
        repo.ticks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tick in
                self?.apply(tick)
            }
            .store(in: &cancellables)
    }
    
    private static func map(_ state: ConnectionState) -> String {
        switch state {
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting..."
        case .connected:
            return "Connected"
        case .failed(let error):
            return "Failed: \(error)"
        }
    }
    
    func toggle() {
        if isRunning {
            stopUseCase.execute()
            isRunning = false
        } else {
            startUseCase.execute(symbols: stocks.map { $0.symbol})
            isRunning = true
        }
    }
    
    private func apply(_ tick: PriceTick) {
        guard let idx = stocks.firstIndex(where: { stock in
            stock.symbol == tick.symbol
        }) else {
            return
        }
        var s = stocks[idx]
        s.previousPrice = s.price
        s.price = tick.price
        stocks[idx] = s
        stocks.sort {
            $0.price > $1.price
        }
    }
}

import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published private(set) var stocks: [StockRowState] = []
    @Published private(set) var connectionState: ConnectionState = .disconnected
    @Published private(set) var isRunning: Bool = false
    
    private let startUseCase: StartStreamingUseCase
    private let stopUseCase: StopStreamingUseCase
    private let repo: PriceStreamingRepository
    
    private var cancellables = Set<AnyCancellable>()
    private var domainStocks: [Stock]
    
    init(stocks: [Stock], startUseCase: StartStreamingUseCase, stopUseCase: StopStreamingUseCase, repo: PriceStreamingRepository) {
        self.domainStocks = stocks
        self.startUseCase = startUseCase
        self.stopUseCase = stopUseCase
        self.repo = repo
        
        self.stocks = stocks.map { StockRowState.from(stock: $0)}
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
            startUseCase.execute(symbols: domainStocks.map { $0.symbol})
            isRunning = true
        }
    }
    
    private func apply(_ tick: PriceTick) {
        guard let idx = domainStocks.firstIndex(where: { stock in
            stock.symbol == tick.symbol
        }) else {
            return
        }
        let oldPrice = domainStocks[idx].price
        domainStocks[idx].previousPrice = domainStocks[idx].price
        domainStocks[idx].price = tick.price
        
        domainStocks.sort { $0.price > $1.price }
        stocks = domainStocks.map { stock in
            StockRowState(id: stock.symbol, symbol: stock.symbol, description: stock.description, price: stock.price, isUp: stock.isUp,
                          isFlashingUp: stock.symbol == tick.symbol && tick.price > oldPrice,
                          isFlashingDown: stock.symbol == tick.symbol && tick.price < oldPrice)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.clearFlash(for: tick.symbol)
        }
    }
    
    private func clearFlash(for symbol: String) {
            stocks = stocks.map { row in
                guard row.symbol == symbol else { return row }
                return StockRowState(
                    id: row.id,
                    symbol: row.symbol,
                    description: row.description,
                    price: row.price,
                    isUp: row.isUp,
                    isFlashingUp: false,
                    isFlashingDown: false
                )
            }
        }

        func stock(for symbol: String) -> Stock? {
            domainStocks.first(where: { $0.symbol == symbol })
        }
}

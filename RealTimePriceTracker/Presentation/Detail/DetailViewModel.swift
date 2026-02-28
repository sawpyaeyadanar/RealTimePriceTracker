import Foundation
import Combine

@MainActor
final class DetailViewModel: ObservableObject {
    @Published private(set) var stock: Stock?
    
    private let symbol: String
    private let repo: PriceStreamingRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(stock: Stock?, symbol: String, repo: PriceStreamingRepository) {
        self.stock = stock
        self.symbol = symbol
        self.repo = repo
        repo.ticks
            .filter { $0.symbol == symbol}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tick in
                self?.apply(tick)
            }
            .store(in: &cancellables)
    }
    
    private func apply(_ tick: PriceTick) {
        guard var s = stock else { return }
        s.previousPrice = s.price
        s.price = tick.price
        stock = s
    }
}

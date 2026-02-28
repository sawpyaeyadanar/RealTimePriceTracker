import Foundation

enum FeedPreview {
    @MainActor static func makeVM() -> FeedViewModel {
        let stocks: [Stock] = [
            Stock(symbol: "AAPL", description: "Apple Inc.", price: 189.22, previousPrice: 185.10),
            Stock(symbol: "TSLA", description: "Tesla Inc.", price: 210.50, previousPrice: 215.00),
            Stock(symbol: "NVDA", description: "NVIDIA Corporation", price: 875.40, previousPrice: 860.00)
        ]

        let repo = PreviewPriceStreamingRepository()
        return FeedViewModel(
            stocks: stocks,
            startUseCase: PreviewStartUseCase(),
            stopUseCase: PreviewStopUseCase(),
            repo: repo
        )
    }
}

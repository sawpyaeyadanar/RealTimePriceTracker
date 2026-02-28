import Foundation

enum DetailPreview {
    @MainActor 
    static func makeVM(symbol: String = "AAPL") -> DetailViewModel {
        let repo = PreviewPriceStreamingRepository()
        let stock = Stock(symbol: symbol,
                          description: "Sample description for \(symbol)",
                          price: 123.45,
                          previousPrice: 120.00)
        return DetailViewModel(stock: stock, symbol: symbol, repo: repo)
    }
}

import Foundation
@MainActor
final class AppContainer: ObservableObject {
    let repo: PriceStreamingRepository
    let feedVM: FeedViewModel
    
    init() {
        let client = URLSessionWebSocketClient(url: URL(string: "wss://ws.postman-echo.com/raw")!, session:  URLSession(configuration: .default))
        let repo = WebSocketPriceStreamingRepository(client: client, generator: RandomPriceGenerator())
        self.repo = repo
        
        let start = DefaultStartStreamingUseCase(repo: repo)
        let stop = DefaultStopStreamingUseCase(repo: repo)
        
        self.feedVM = FeedViewModel(stocks: StockSeeds.seed25(),
                                    startUseCase: start,
                                    stopUseCase: stop,
                                    repo: repo)
    }
    
    func makeDetailVM(symbol: String) -> DetailViewModel {
        let stock = feedVM.stocks.first(where: { $0.symbol == symbol})
        return DetailViewModel(stock: stock, symbol: symbol, repo: repo)
    }
}

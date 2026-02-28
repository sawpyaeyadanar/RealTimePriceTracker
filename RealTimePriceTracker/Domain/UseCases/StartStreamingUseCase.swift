import Foundation

public protocol StartStreamingUseCase {
    func execute(symbols: [String])
}

public final class DefaultStartStreamingUseCase: StartStreamingUseCase {
    private let repo: PriceStreamingRepository
    public init(repo: PriceStreamingRepository) {
        self.repo = repo
    }
    
    public func execute(symbols: [String]) {
        repo.connect()
        repo.startSendingTicks(symbols: symbols)
    }
}



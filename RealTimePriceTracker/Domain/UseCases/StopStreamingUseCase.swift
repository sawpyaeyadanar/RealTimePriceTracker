import Foundation

public protocol StopStreamingUseCase {
    func execute()
}

public final class DefaultStopStreamingUseCase: StopStreamingUseCase {
    private let repo: PriceStreamingRepository
    init(repo: PriceStreamingRepository) {
        self.repo = repo
    }
    public func execute() {
        repo.stopSendingTicks()
        repo.disconnect()
    }
}

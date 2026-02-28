import SwiftUI

@main
struct RealTimePriceTrackerApp: App {
    @StateObject private var container = AppContainer()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FeedView(
                    viewModel: container.feedVM,
                    makeDetail: container.makeDetailVM(symbol:)
                )
            }
        }
    }
}

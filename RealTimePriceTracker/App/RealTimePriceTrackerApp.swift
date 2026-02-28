import SwiftUI

@main
struct RealTimePriceTrackerApp: App {
    @StateObject private var container = AppContainer()
    @State private var path = NavigationPath()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                FeedView(
                    viewModel: container.feedVM,
                    makeDetail: container.makeDetailVM(symbol:)
                )
                .navigationDestination(for: String.self) { symbol in
                    DetailView(viewModel: container.makeDetailVM(symbol: symbol))
                }
            }
            .onOpenURL(perform: { url in
                guard let symbol = DeepLinkParser.parseSymbol(url: url) else { return }
                    path.append(symbol)
            })
        }
    }
}

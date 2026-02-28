import Foundation
enum DeepLinkParser {
    static func parseSymbol(url: URL) -> String? {
        guard let scheme = url.scheme,
              scheme == "stocks" || scheme == "pricetracker",
              url.host == "symbol" else { return nil }

        let symbol = url.lastPathComponent
        return symbol.isEmpty ? nil : symbol
    }
}

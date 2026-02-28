import XCTest

@testable import RealTimePriceTracker

final class DeepLinkParserTests: XCTestCase {
    func test_parseSymbol_validStocksScheme() {
        let url = URL(string: "stocks://symbol/AAPL")!
        XCTAssertEqual(DeepLinkParser.parseSymbol(url: url), "AAPL")
    }

    func test_parseSymbol_validCustomScheme() {
        let url = URL(string: "pricetracker://symbol/TSLA")!
        XCTAssertEqual(DeepLinkParser.parseSymbol(url: url), "TSLA")
    }

    func test_parseSymbol_invalidHost_returnsNil() {
        let url = URL(string: "pricetracker://wrong/AAPL")!
        XCTAssertNil(DeepLinkParser.parseSymbol(url: url))
    }
}

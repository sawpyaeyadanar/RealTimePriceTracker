import Foundation

public struct Stock: Identifiable, Equatable {
    public let id: String           
    public let symbol: String
    public let description: String
    public var price: Double
    public var previousPrice: Double

    public var isUp: Bool { price >= previousPrice }

    public init(symbol: String, description: String, price: Double, previousPrice: Double) {
        self.id = symbol
        self.symbol = symbol
        self.description = description
        self.price = price
        self.previousPrice = previousPrice
    }
}

import Foundation

public struct PriceTick: Equatable, Codable {
    public let symbol: String
    public let price: Double
    public let ts: TimeInterval
}

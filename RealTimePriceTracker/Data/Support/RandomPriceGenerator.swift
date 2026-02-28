import Foundation

public protocol PriceGenerating {
    func nextPrice() -> Double
}

public struct RandomPriceGenerator: PriceGenerating {
    
    public init() {}
    public func nextPrice() -> Double {
        Double.random(in: 50...500)
    }
}

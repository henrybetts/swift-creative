@testable import Creative

/// Whether two values are within `tolerance` of each other, by Euclidean distance.
func isApproximatelyEqual<V: SIMDRepresentable>(_ a: V, _ b: V, tolerance: Float = 1e-6) -> Bool
where V.RawValue.Scalar == Float {
    let difference = a.rawValue - b.rawValue
    return (difference * difference).sum() <= tolerance * tolerance
}

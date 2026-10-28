/// A value type that wraps a SIMD value, giving it a more specific meaning.
///
/// Conforming types are encoded as their underlying SIMD value, e.g. `[1, 2]`.
public protocol SIMDRepresentable: RawRepresentable, Hashable, Codable, Sendable where RawValue: SIMD {
    /// Creates a value wrapping the given SIMD value.
    init(rawValue: RawValue)
}

extension SIMDRepresentable {
    /// Creates a value wrapping the given SIMD value.
    public init(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }

    public init(from decoder: any Decoder) throws {
        self.init(rawValue: try RawValue(from: decoder))
    }

    public func encode(to encoder: any Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}

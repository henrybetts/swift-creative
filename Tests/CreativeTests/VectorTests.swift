// Generated from VectorTests.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.
import Foundation
import Testing
@testable import Creative

private func isApproximatelyEqual<V: SIMDRepresentable>(_ a: V, _ b: V, tolerance: Float = 1e-6) -> Bool
where V.RawValue.Scalar == Float {
    let difference = a.rawValue - b.rawValue
    return (difference * difference).sum() <= tolerance * tolerance
}

@Suite struct Vector2DTests {
    let a = Vector2D(1, 2)
    let b = Vector2D(5, 6)

    @Test func components() {
        #expect(a.x == 1)
        #expect(a.y == 2)
        #expect(a.rawValue == SIMD2(1, 2))
        #expect(a == Vector2D(x: 1, y: 2))
    }

    @Test func settingComponents() {
        var vector = Vector2D.zero
        vector.x = 1
        vector.y = 2
        #expect(vector == a)
    }

    @Test func constants() {
        #expect(Vector2D.zero == Vector2D(0, 0))
        #expect(Vector2D.one == Vector2D(1, 1))
    }

    @Test func addition() {
        #expect(a + b == Vector2D(6, 8))
    }

    @Test func subtraction() {
        #expect(b - a == Vector2D(4, 4))
    }

    @Test func negation() {
        #expect(-a == Vector2D(-1, -2))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Vector2D(2, 4))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Vector2D(0.5, 1.0))
    }

    @Test func componentWiseMultiplicationAndDivision() {
        let product = Vector2D(5, 12)
        #expect(a * b == product)
        #expect(product / a == b)
    }

    @Test func compoundAssignment() {
        var vector = a
        vector += b
        vector -= a
        #expect(vector == b)
        vector *= 2
        vector /= 2
        #expect(vector == b)
        vector *= a
        vector /= a
        #expect(vector == b)
    }

    @Test func dot() {
        #expect(a.dot(b) == 17)
    }

    @Test func length() {
        let vector = Vector2D(3, 4)
        #expect(vector.length == 5)
        #expect(vector.lengthSquared == 25)
    }

    @Test func normalized() {
        let vector = Vector2D(3, 4)
        #expect(isApproximatelyEqual(vector.normalized, Vector2D(0.6, 0.8)))
        #expect(Vector2D.zero.normalized == .zero)
    }

    @Test func normalize() {
        var vector = Vector2D(3, 4)
        vector.normalize()
        #expect(vector == Vector2D(3, 4).normalized)
    }

    @Test func description() {
        #expect(a.description == "Vector2D(x: 1.0, y: 2.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2]")
        #expect(try JSONDecoder().decode(Vector2D.self, from: data) == a)
    }
}

@Suite struct Vector3DTests {
    let a = Vector3D(1, 2, 3)
    let b = Vector3D(5, 6, 7)

    @Test func components() {
        #expect(a.x == 1)
        #expect(a.y == 2)
        #expect(a.z == 3)
        #expect(a.rawValue == SIMD3(1, 2, 3))
        #expect(a == Vector3D(x: 1, y: 2, z: 3))
    }

    @Test func settingComponents() {
        var vector = Vector3D.zero
        vector.x = 1
        vector.y = 2
        vector.z = 3
        #expect(vector == a)
    }

    @Test func constants() {
        #expect(Vector3D.zero == Vector3D(0, 0, 0))
        #expect(Vector3D.one == Vector3D(1, 1, 1))
    }

    @Test func addition() {
        #expect(a + b == Vector3D(6, 8, 10))
    }

    @Test func subtraction() {
        #expect(b - a == Vector3D(4, 4, 4))
    }

    @Test func negation() {
        #expect(-a == Vector3D(-1, -2, -3))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Vector3D(2, 4, 6))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Vector3D(0.5, 1.0, 1.5))
    }

    @Test func componentWiseMultiplicationAndDivision() {
        let product = Vector3D(5, 12, 21)
        #expect(a * b == product)
        #expect(product / a == b)
    }

    @Test func compoundAssignment() {
        var vector = a
        vector += b
        vector -= a
        #expect(vector == b)
        vector *= 2
        vector /= 2
        #expect(vector == b)
        vector *= a
        vector /= a
        #expect(vector == b)
    }

    @Test func dot() {
        #expect(a.dot(b) == 38)
    }

    @Test func length() {
        let vector = Vector3D(2, 3, 6)
        #expect(vector.length == 7)
        #expect(vector.lengthSquared == 49)
    }

    @Test func normalized() {
        let vector = Vector3D(2, 3, 6)
        #expect(isApproximatelyEqual(vector.normalized, Vector3D(0.2857142857142857, 0.42857142857142855, 0.8571428571428571)))
        #expect(Vector3D.zero.normalized == .zero)
    }

    @Test func normalize() {
        var vector = Vector3D(2, 3, 6)
        vector.normalize()
        #expect(vector == Vector3D(2, 3, 6).normalized)
    }

    @Test func cross() {
        let x = Vector3D(1, 0, 0)
        let y = Vector3D(0, 1, 0)
        #expect(x.cross(y) == Vector3D(0, 0, 1))
        #expect(y.cross(x) == Vector3D(0, 0, -1))
        #expect(a.cross(a) == .zero)
    }

    @Test func description() {
        #expect(a.description == "Vector3D(x: 1.0, y: 2.0, z: 3.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2,3]")
        #expect(try JSONDecoder().decode(Vector3D.self, from: data) == a)
    }
}

@Suite struct Vector4DTests {
    let a = Vector4D(1, 2, 3, 4)
    let b = Vector4D(5, 6, 7, 8)

    @Test func components() {
        #expect(a.x == 1)
        #expect(a.y == 2)
        #expect(a.z == 3)
        #expect(a.w == 4)
        #expect(a.rawValue == SIMD4(1, 2, 3, 4))
        #expect(a == Vector4D(x: 1, y: 2, z: 3, w: 4))
    }

    @Test func settingComponents() {
        var vector = Vector4D.zero
        vector.x = 1
        vector.y = 2
        vector.z = 3
        vector.w = 4
        #expect(vector == a)
    }

    @Test func constants() {
        #expect(Vector4D.zero == Vector4D(0, 0, 0, 0))
        #expect(Vector4D.one == Vector4D(1, 1, 1, 1))
    }

    @Test func addition() {
        #expect(a + b == Vector4D(6, 8, 10, 12))
    }

    @Test func subtraction() {
        #expect(b - a == Vector4D(4, 4, 4, 4))
    }

    @Test func negation() {
        #expect(-a == Vector4D(-1, -2, -3, -4))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Vector4D(2, 4, 6, 8))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Vector4D(0.5, 1.0, 1.5, 2.0))
    }

    @Test func componentWiseMultiplicationAndDivision() {
        let product = Vector4D(5, 12, 21, 32)
        #expect(a * b == product)
        #expect(product / a == b)
    }

    @Test func compoundAssignment() {
        var vector = a
        vector += b
        vector -= a
        #expect(vector == b)
        vector *= 2
        vector /= 2
        #expect(vector == b)
        vector *= a
        vector /= a
        #expect(vector == b)
    }

    @Test func dot() {
        #expect(a.dot(b) == 70)
    }

    @Test func length() {
        let vector = Vector4D(1, 2, 2, 4)
        #expect(vector.length == 5)
        #expect(vector.lengthSquared == 25)
    }

    @Test func normalized() {
        let vector = Vector4D(1, 2, 2, 4)
        #expect(isApproximatelyEqual(vector.normalized, Vector4D(0.2, 0.4, 0.4, 0.8)))
        #expect(Vector4D.zero.normalized == .zero)
    }

    @Test func normalize() {
        var vector = Vector4D(1, 2, 2, 4)
        vector.normalize()
        #expect(vector == Vector4D(1, 2, 2, 4).normalized)
    }

    @Test func description() {
        #expect(a.description == "Vector4D(x: 1.0, y: 2.0, z: 3.0, w: 4.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2,3,4]")
        #expect(try JSONDecoder().decode(Vector4D.self, from: data) == a)
    }
}

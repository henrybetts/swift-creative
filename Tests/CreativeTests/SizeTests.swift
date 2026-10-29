// Generated from SizeTests.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.
import Foundation
import Testing
@testable import Creative

@Suite struct Size2DTests {
    let a = Size2D(1, 2)
    let b = Size2D(5, 6)
    let v = Vector2D(5, 6)

    @Test func components() {
        #expect(a.width == 1)
        #expect(a.height == 2)
        #expect(a.rawValue == SIMD2(1, 2))
        #expect(a == Size2D(width: 1, height: 2))
    }

    @Test func settingComponents() {
        var size = Size2D.zero
        size.width = 1
        size.height = 2
        #expect(size == a)
    }

    @Test func constants() {
        #expect(Size2D.zero == Size2D(0, 0))
        #expect(Size2D.one == Size2D(1, 1))
    }

    @Test func addition() {
        #expect(a + b == Size2D(6, 8))
    }

    @Test func subtraction() {
        #expect(b - a == Size2D(4, 4))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Size2D(2, 4))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Size2D(0.5, 1.0))
    }

    @Test func componentWiseMultiplicationAndDivision() {
        let product = Size2D(5, 12)
        #expect(a * b == product)
        #expect(product / a == b)
    }

    @Test func vectorAdditionAndSubtraction() {
        #expect(a + v == Size2D(6, 8))
        #expect(a - v == Size2D(-4, -4))
    }

    @Test func compoundAssignment() {
        var size = a
        size += b
        size -= a
        #expect(size == b)
        size *= 2
        size /= 2
        #expect(size == b)
        size *= a
        size /= a
        #expect(size == b)
        size += v
        size -= v
        #expect(size == b)
    }

    @Test func vectorConversion() {
        #expect(Vector2D(a) == Vector2D(1, 2))
        #expect(Size2D(v) == b)
    }

    @Test func pointConversion() {
        #expect(Size2D(Point2D(1, 2)) == a)
    }

    @Test func description() {
        #expect(a.description == "Size2D(width: 1.0, height: 2.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2]")
        #expect(try JSONDecoder().decode(Size2D.self, from: data) == a)
    }
}

@Suite struct Size3DTests {
    let a = Size3D(1, 2, 3)
    let b = Size3D(5, 6, 7)
    let v = Vector3D(5, 6, 7)

    @Test func components() {
        #expect(a.width == 1)
        #expect(a.height == 2)
        #expect(a.depth == 3)
        #expect(a.rawValue == SIMD3(1, 2, 3))
        #expect(a == Size3D(width: 1, height: 2, depth: 3))
    }

    @Test func settingComponents() {
        var size = Size3D.zero
        size.width = 1
        size.height = 2
        size.depth = 3
        #expect(size == a)
    }

    @Test func constants() {
        #expect(Size3D.zero == Size3D(0, 0, 0))
        #expect(Size3D.one == Size3D(1, 1, 1))
    }

    @Test func addition() {
        #expect(a + b == Size3D(6, 8, 10))
    }

    @Test func subtraction() {
        #expect(b - a == Size3D(4, 4, 4))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Size3D(2, 4, 6))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Size3D(0.5, 1.0, 1.5))
    }

    @Test func componentWiseMultiplicationAndDivision() {
        let product = Size3D(5, 12, 21)
        #expect(a * b == product)
        #expect(product / a == b)
    }

    @Test func vectorAdditionAndSubtraction() {
        #expect(a + v == Size3D(6, 8, 10))
        #expect(a - v == Size3D(-4, -4, -4))
    }

    @Test func compoundAssignment() {
        var size = a
        size += b
        size -= a
        #expect(size == b)
        size *= 2
        size /= 2
        #expect(size == b)
        size *= a
        size /= a
        #expect(size == b)
        size += v
        size -= v
        #expect(size == b)
    }

    @Test func vectorConversion() {
        #expect(Vector3D(a) == Vector3D(1, 2, 3))
        #expect(Size3D(v) == b)
    }

    @Test func pointConversion() {
        #expect(Size3D(Point3D(1, 2, 3)) == a)
    }

    @Test func description() {
        #expect(a.description == "Size3D(width: 1.0, height: 2.0, depth: 3.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2,3]")
        #expect(try JSONDecoder().decode(Size3D.self, from: data) == a)
    }
}

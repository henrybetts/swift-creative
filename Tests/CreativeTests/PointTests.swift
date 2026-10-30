// Generated from PointTests.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.
import Foundation
import Testing
@testable import Creative

@Suite struct Point2DTests {
    let a = Point2D(1, 2)
    let b = Point2D(5, 6)
    let v = Vector2D(5, 6)
    let s = Size2D(5, 6)

    @Test func components() {
        #expect(a.x == 1)
        #expect(a.y == 2)
        #expect(a.rawValue == SIMD2(1, 2))
        #expect(a == Point2D(x: 1, y: 2))
    }

    @Test func settingComponents() {
        var point = Point2D.origin
        point.x = 1
        point.y = 2
        #expect(point == a)
    }

    @Test func origin() {
        #expect(Point2D.origin == Point2D(0, 0))
    }

    @Test func pointSubtraction() {
        #expect(b - a == Vector2D(4, 4))
    }

    @Test func vectorAdditionAndSubtraction() {
        #expect(a + v == Point2D(6, 8))
        #expect(a - v == Point2D(-4, -4))
    }

    @Test func compoundAssignment() {
        var point = a
        point += v
        #expect(point == a + v)
        point -= v
        #expect(point == a)
    }

    @Test func sizeAdditionAndSubtraction() {
        #expect(a + s == Point2D(6, 8))
        #expect(a - s == Point2D(-4, -4))
    }

    @Test func sizeMultiplicationAndDivision() {
        let product = Point2D(5, 12)
        #expect(a * s == product)
        #expect(product / s == a)
    }

    @Test func sizeCompoundAssignment() {
        var point = a
        point += s
        point -= s
        #expect(point == a)
        point *= s
        point /= s
        #expect(point == a)
    }

    @Test func distance() {
        let other = a + Vector2D(3, 4)
        #expect(a.distance(to: other) == 5)
        #expect(a.distanceSquared(to: other) == 25)
    }

    @Test func vectorConversion() {
        #expect(Vector2D(a) == Vector2D(1, 2))
        #expect(Point2D(v) == b)
    }

    @Test func sizeConversion() {
        #expect(Point2D(s) == b)
    }

    @Test func description() {
        #expect(a.description == "(1, 2)")
    }

    @Test func debugDescription() {
        #expect(a.debugDescription == "Point2D(x: 1.0, y: 2.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2]")
        #expect(try JSONDecoder().decode(Point2D.self, from: data) == a)
    }
}

@Suite struct Point3DTests {
    let a = Point3D(1, 2, 3)
    let b = Point3D(5, 6, 7)
    let v = Vector3D(5, 6, 7)
    let s = Size3D(5, 6, 7)

    @Test func components() {
        #expect(a.x == 1)
        #expect(a.y == 2)
        #expect(a.z == 3)
        #expect(a.rawValue == SIMD3(1, 2, 3))
        #expect(a == Point3D(x: 1, y: 2, z: 3))
    }

    @Test func settingComponents() {
        var point = Point3D.origin
        point.x = 1
        point.y = 2
        point.z = 3
        #expect(point == a)
    }

    @Test func origin() {
        #expect(Point3D.origin == Point3D(0, 0, 0))
    }

    @Test func pointSubtraction() {
        #expect(b - a == Vector3D(4, 4, 4))
    }

    @Test func vectorAdditionAndSubtraction() {
        #expect(a + v == Point3D(6, 8, 10))
        #expect(a - v == Point3D(-4, -4, -4))
    }

    @Test func compoundAssignment() {
        var point = a
        point += v
        #expect(point == a + v)
        point -= v
        #expect(point == a)
    }

    @Test func sizeAdditionAndSubtraction() {
        #expect(a + s == Point3D(6, 8, 10))
        #expect(a - s == Point3D(-4, -4, -4))
    }

    @Test func sizeMultiplicationAndDivision() {
        let product = Point3D(5, 12, 21)
        #expect(a * s == product)
        #expect(product / s == a)
    }

    @Test func sizeCompoundAssignment() {
        var point = a
        point += s
        point -= s
        #expect(point == a)
        point *= s
        point /= s
        #expect(point == a)
    }

    @Test func distance() {
        let other = a + Vector3D(2, 3, 6)
        #expect(a.distance(to: other) == 7)
        #expect(a.distanceSquared(to: other) == 49)
    }

    @Test func vectorConversion() {
        #expect(Vector3D(a) == Vector3D(1, 2, 3))
        #expect(Point3D(v) == b)
    }

    @Test func sizeConversion() {
        #expect(Point3D(s) == b)
    }

    @Test func description() {
        #expect(a.description == "(1, 2, 3)")
    }

    @Test func debugDescription() {
        #expect(a.debugDescription == "Point3D(x: 1.0, y: 2.0, z: 3.0)")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[1,2,3]")
        #expect(try JSONDecoder().decode(Point3D.self, from: data) == a)
    }
}

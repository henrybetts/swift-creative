import Foundation
import Testing
@testable import Creative

@Suite struct Rectangle2DTests {
    let rectangle = Rectangle2D(x: 1, y: 2, width: 3, height: 4)
    let flipped = Rectangle2D(x: 4, y: 6, width: -3, height: -4)

    @Test func inits() {
        #expect(rectangle == Rectangle2D(origin: Point2D(1, 2), size: Size2D(3, 4)))
    }

    @Test func properties() {
        var rectangle = rectangle
        rectangle.origin = Point2D(5, 6)
        rectangle.size.width = 7
        #expect(rectangle == Rectangle2D(x: 5, y: 6, width: 7, height: 4))
    }

    @Test func derivedProperties() {
        #expect(rectangle.width == 3)
        #expect(rectangle.height == 4)
        #expect(rectangle.minX == 1)
        #expect(rectangle.maxX == 4)
        #expect(rectangle.minY == 2)
        #expect(rectangle.maxY == 6)
        #expect(rectangle.center == Point2D(2.5, 4))
    }

    @Test func negativeSize() {
        #expect(flipped.width == -3)
        #expect(flipped.height == -4)
        #expect(flipped.minX == 1)
        #expect(flipped.maxX == 4)
        #expect(flipped.minY == 2)
        #expect(flipped.maxY == 6)
        #expect(flipped.center == Point2D(2.5, 4))
    }

    @Test func standardized() {
        #expect(flipped.standardized == rectangle)
        #expect(rectangle.standardized == rectangle)
    }

    @Test func codable() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(rectangle)
        #expect(String(decoding: data, as: UTF8.self) == #"{"origin":[1,2],"size":[3,4]}"#)
        #expect(try JSONDecoder().decode(Rectangle2D.self, from: data) == rectangle)
    }

    @Test func description() {
        #expect(rectangle.description == "(1, 2) 3 × 4")
    }

    @Test func debugDescription() {
        #expect(rectangle.debugDescription == "Rectangle2D(x: 1.0, y: 2.0, width: 3.0, height: 4.0)")
    }

    @Test func mesh() {
        let expected = Mesh2D(
            positions: [Point2D(1, 2), Point2D(4, 2), Point2D(4, 6), Point2D(1, 6)],
            indices: [0, 1, 2, 0, 2, 3])
        #expect(rectangle.mesh == expected)
        #expect(flipped.mesh == expected)
    }
}

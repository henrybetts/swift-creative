import Foundation
import Testing
@testable import Creative

@Suite struct Circle2DTests {
    let circle = Circle2D(center: Point2D(1, 2), radius: 3)

    @Test func properties() {
        var circle = circle
        circle.center = Point2D(4, 5)
        circle.radius = 6
        #expect(circle.center == Point2D(4, 5))
        #expect(circle.radius == 6)
    }

    @Test func codable() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(circle)
        #expect(String(decoding: data, as: UTF8.self) == #"{"center":[1,2],"radius":3}"#)
        #expect(try JSONDecoder().decode(Circle2D.self, from: data) == circle)
    }

    @Test func description() {
        #expect(circle.description == "(1, 2) r3")
    }

    @Test func debugDescription() {
        #expect(circle.debugDescription == "Circle2D(center: Point2D(x: 1.0, y: 2.0), radius: 3.0)")
    }
}

import Foundation
import Testing
@testable import Creative

@Suite struct RegularPolygon2DTests {
    let polygon = RegularPolygon2D(circumcircle: Circle2D(center: Point2D(1, 2), radius: 3), sideCount: 6)

    @Test func properties() {
        var polygon = polygon
        polygon.circumcircle = Circle2D(center: Point2D(4, 5), radius: 6)
        polygon.sideCount = 8
        #expect(polygon.circumcircle == Circle2D(center: Point2D(4, 5), radius: 6))
        #expect(polygon.sideCount == 8)
    }

    @Test func codable() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(polygon)
        #expect(String(decoding: data, as: UTF8.self) == #"{"circumcircle":{"center":[1,2],"radius":3},"sideCount":6}"#)
        #expect(try JSONDecoder().decode(RegularPolygon2D.self, from: data) == polygon)
    }

    @Test func description() {
        #expect(polygon.description == "(1, 2) r3 ×6")
    }

    @Test func debugDescription() {
        #expect(polygon.debugDescription
            == "RegularPolygon2D(circumcircle: Circle2D(center: Point2D(x: 1.0, y: 2.0), radius: 3.0), sideCount: 6)")
    }
}

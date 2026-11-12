import Foundation
import Testing
@testable import Creative

@Suite struct Triangle2DTests {
    let triangle = Triangle2D(Point2D(0, 0), Point2D(1, 0), Point2D(0, 1))

    @Test func inits() {
        #expect(triangle == Triangle2D(vertices: (Point2D(0, 0), Point2D(1, 0), Point2D(0, 1))))
    }

    @Test func properties() {
        var triangle = triangle
        triangle.vertices.2.x = 2
        #expect(triangle.vertices == (Point2D(0, 0), Point2D(1, 0), Point2D(2, 1)))
    }

    @Test func equality() {
        #expect(triangle != Triangle2D(Point2D(1, 0), Point2D(0, 1), Point2D(0, 0)))
        #expect(triangle.hashValue == Triangle2D(Point2D(0, 0), Point2D(1, 0), Point2D(0, 1)).hashValue)
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(triangle)
        #expect(String(decoding: data, as: UTF8.self) == "[[0,0],[1,0],[0,1]]")
        #expect(try JSONDecoder().decode(Triangle2D.self, from: data) == triangle)
    }

    @Test func description() {
        #expect(triangle.description == "[(0, 0), (1, 0), (0, 1)]")
    }

    @Test func debugDescription() {
        #expect(triangle.debugDescription == "Triangle2D(Point2D(x: 0.0, y: 0.0), Point2D(x: 1.0, y: 0.0), Point2D(x: 0.0, y: 1.0))")
    }

    @Test func mesh() {
        #expect(triangle.mesh == Mesh2D(positions: [Point2D(0, 0), Point2D(1, 0), Point2D(0, 1)]))
    }

    @Test func clockwiseMesh() {
        let clockwise = Triangle2D(Point2D(0, 0), Point2D(0, 1), Point2D(1, 0))
        #expect(clockwise.mesh.positions == [Point2D(0, 0), Point2D(1, 0), Point2D(0, 1)])
    }
}

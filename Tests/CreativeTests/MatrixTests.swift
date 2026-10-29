// Generated from MatrixTests.swift.gyb - do not edit directly. Run Scripts/gyb to regenerate.
import Foundation
import Testing
@testable import Creative

@Suite struct Matrix2x2Tests {
    let a = Matrix2x2(rows: (Vector2D(3, 2), Vector2D(1, 1)))
    let b = Matrix2x2(rows: (Vector2D(1, 2), Vector2D(3, 4)))

    @Test func rowsAndColumns() {
        #expect(a == Matrix2x2(Vector2D(3, 1), Vector2D(2, 1)))
        #expect(a == Matrix2x2(columns: (Vector2D(3, 1), Vector2D(2, 1))))
    }

    @Test func subscripts() {
        #expect(a[1] == Vector2D(2, 1))
        #expect(a[1, 0] == 2)
        var matrix = Matrix2x2.zero
        matrix[1] = Vector2D(1, 2)
        matrix[0, 1] = 5
        #expect(matrix[1] == Vector2D(1, 2))
        #expect(matrix[0] == Vector2D(0, 5))
    }

    @Test func constants() {
        #expect(Matrix2x2.zero == Matrix2x2(rows: (Vector2D(0, 0), Vector2D(0, 0))))
        #expect(Matrix2x2.identity == Matrix2x2(rows: (Vector2D(1, 0), Vector2D(0, 1))))
        #expect(Matrix2x2(diagonal: Vector2D(1, 2)) == Matrix2x2(rows: (Vector2D(1, 0), Vector2D(0, 2))))
    }

    @Test func transpose() {
        #expect(a.transpose == Matrix2x2(rows: (Vector2D(3, 1), Vector2D(2, 1))))
    }

    @Test func determinant() {
        #expect(a.determinant == 1)
        #expect(a.transpose.determinant == 1)
        #expect(Matrix2x2(diagonal: Vector2D(1, 2)).determinant == 2)
        #expect(b.determinant == -2)
    }

    @Test func inverse() {
        #expect(a.inverse == Matrix2x2(rows: (Vector2D(1, -2), Vector2D(-1, 3))))
        #expect(a * a.inverse == .identity)
        #expect(a.inverse * a == .identity)
    }

    @Test func singularInverse() {
        #expect(!Matrix2x2.zero.inverse[0, 0].isFinite)
    }

    @Test func matrixMultiplication() {
        #expect(a * b == Matrix2x2(rows: (Vector2D(9, 14), Vector2D(4, 6))))
        #expect(b * a == Matrix2x2(rows: (Vector2D(5, 4), Vector2D(13, 10))))
        #expect(a * .identity == a)
    }

    @Test func vectorMultiplication() {
        let vector = Vector2D(1, 2)
        #expect(a * vector == Vector2D(7, 3))
        #expect(vector * a == Vector2D(5, 4))
        #expect(vector * a == a.transpose * vector)
    }

    @Test func addition() {
        #expect(a + b == Matrix2x2(rows: (Vector2D(4, 4), Vector2D(4, 5))))
    }

    @Test func subtraction() {
        #expect(b - a == Matrix2x2(rows: (Vector2D(-2, 0), Vector2D(2, 3))))
    }

    @Test func negation() {
        #expect(-a == Matrix2x2(rows: (Vector2D(-3, -2), Vector2D(-1, -1))))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Matrix2x2(rows: (Vector2D(6, 4), Vector2D(2, 2))))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Matrix2x2(rows: (Vector2D(1.5, 1.0), Vector2D(0.5, 0.5))))
    }

    @Test func compoundAssignment() {
        var matrix = a
        matrix += b
        matrix -= a
        #expect(matrix == b)
        matrix *= 2
        matrix /= 2
        #expect(matrix == b)
        matrix *= a
        #expect(matrix == b * a)
    }

    @Test func description() {
        #expect(a.description == "Matrix2x2(columns: (Vector2D(x: 3.0, y: 1.0), Vector2D(x: 2.0, y: 1.0)))")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[[3,1],[2,1]]")
        #expect(try JSONDecoder().decode(Matrix2x2.self, from: data) == a)
    }
}

@Suite struct Matrix3x3Tests {
    let a = Matrix3x3(rows: (Vector3D(1, 2, 3), Vector3D(0, 1, 4), Vector3D(5, 6, 0)))
    let b = Matrix3x3(rows: (Vector3D(1, 2, 3), Vector3D(4, 5, 6), Vector3D(7, 8, 9)))

    @Test func rowsAndColumns() {
        #expect(a == Matrix3x3(Vector3D(1, 0, 5), Vector3D(2, 1, 6), Vector3D(3, 4, 0)))
        #expect(a == Matrix3x3(columns: (Vector3D(1, 0, 5), Vector3D(2, 1, 6), Vector3D(3, 4, 0))))
    }

    @Test func subscripts() {
        #expect(a[1] == Vector3D(2, 1, 6))
        #expect(a[1, 0] == 2)
        var matrix = Matrix3x3.zero
        matrix[1] = Vector3D(1, 2, 3)
        matrix[0, 1] = 5
        #expect(matrix[1] == Vector3D(1, 2, 3))
        #expect(matrix[0] == Vector3D(0, 5, 0))
    }

    @Test func constants() {
        #expect(Matrix3x3.zero == Matrix3x3(rows: (Vector3D(0, 0, 0), Vector3D(0, 0, 0), Vector3D(0, 0, 0))))
        #expect(Matrix3x3.identity == Matrix3x3(rows: (Vector3D(1, 0, 0), Vector3D(0, 1, 0), Vector3D(0, 0, 1))))
        #expect(Matrix3x3(diagonal: Vector3D(1, 2, 3)) == Matrix3x3(rows: (Vector3D(1, 0, 0), Vector3D(0, 2, 0), Vector3D(0, 0, 3))))
    }

    @Test func transpose() {
        #expect(a.transpose == Matrix3x3(rows: (Vector3D(1, 0, 5), Vector3D(2, 1, 6), Vector3D(3, 4, 0))))
    }

    @Test func determinant() {
        #expect(a.determinant == 1)
        #expect(a.transpose.determinant == 1)
        #expect(Matrix3x3(diagonal: Vector3D(1, 2, 3)).determinant == 6)
        #expect(b.determinant == 0)
    }

    @Test func inverse() {
        #expect(a.inverse == Matrix3x3(rows: (Vector3D(-24, 18, 5), Vector3D(20, -15, -4), Vector3D(-5, 4, 1))))
        #expect(a * a.inverse == .identity)
        #expect(a.inverse * a == .identity)
    }

    @Test func singularInverse() {
        #expect(!Matrix3x3.zero.inverse[0, 0].isFinite)
    }

    @Test func matrixMultiplication() {
        #expect(a * b == Matrix3x3(rows: (Vector3D(30, 36, 42), Vector3D(32, 37, 42), Vector3D(29, 40, 51))))
        #expect(b * a == Matrix3x3(rows: (Vector3D(16, 22, 11), Vector3D(34, 49, 32), Vector3D(52, 76, 53))))
        #expect(a * .identity == a)
    }

    @Test func vectorMultiplication() {
        let vector = Vector3D(1, 2, 3)
        #expect(a * vector == Vector3D(14, 14, 17))
        #expect(vector * a == Vector3D(16, 22, 11))
        #expect(vector * a == a.transpose * vector)
    }

    @Test func addition() {
        #expect(a + b == Matrix3x3(rows: (Vector3D(2, 4, 6), Vector3D(4, 6, 10), Vector3D(12, 14, 9))))
    }

    @Test func subtraction() {
        #expect(b - a == Matrix3x3(rows: (Vector3D(0, 0, 0), Vector3D(4, 4, 2), Vector3D(2, 2, 9))))
    }

    @Test func negation() {
        #expect(-a == Matrix3x3(rows: (Vector3D(-1, -2, -3), Vector3D(0, -1, -4), Vector3D(-5, -6, 0))))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Matrix3x3(rows: (Vector3D(2, 4, 6), Vector3D(0, 2, 8), Vector3D(10, 12, 0))))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Matrix3x3(rows: (Vector3D(0.5, 1.0, 1.5), Vector3D(0.0, 0.5, 2.0), Vector3D(2.5, 3.0, 0.0))))
    }

    @Test func compoundAssignment() {
        var matrix = a
        matrix += b
        matrix -= a
        #expect(matrix == b)
        matrix *= 2
        matrix /= 2
        #expect(matrix == b)
        matrix *= a
        #expect(matrix == b * a)
    }

    @Test func description() {
        #expect(a.description == "Matrix3x3(columns: (Vector3D(x: 1.0, y: 0.0, z: 5.0), Vector3D(x: 2.0, y: 1.0, z: 6.0), Vector3D(x: 3.0, y: 4.0, z: 0.0)))")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[[1,0,5],[2,1,6],[3,4,0]]")
        #expect(try JSONDecoder().decode(Matrix3x3.self, from: data) == a)
    }
}

@Suite struct Matrix4x4Tests {
    let a = Matrix4x4(rows: (Vector4D(1, 2, 0, 1), Vector4D(0, 1, 3, 0), Vector4D(2, 4, 1, 2), Vector4D(1, 0, 0, 2)))
    let b = Matrix4x4(rows: (Vector4D(1, 2, 3, 4), Vector4D(5, 6, 7, 8), Vector4D(9, 10, 11, 12), Vector4D(13, 14, 15, 16)))

    @Test func rowsAndColumns() {
        #expect(a == Matrix4x4(Vector4D(1, 0, 2, 1), Vector4D(2, 1, 4, 0), Vector4D(0, 3, 1, 0), Vector4D(1, 0, 2, 2)))
        #expect(a == Matrix4x4(columns: (Vector4D(1, 0, 2, 1), Vector4D(2, 1, 4, 0), Vector4D(0, 3, 1, 0), Vector4D(1, 0, 2, 2))))
    }

    @Test func subscripts() {
        #expect(a[1] == Vector4D(2, 1, 4, 0))
        #expect(a[1, 0] == 2)
        var matrix = Matrix4x4.zero
        matrix[1] = Vector4D(1, 2, 3, 4)
        matrix[0, 1] = 5
        #expect(matrix[1] == Vector4D(1, 2, 3, 4))
        #expect(matrix[0] == Vector4D(0, 5, 0, 0))
    }

    @Test func constants() {
        #expect(Matrix4x4.zero == Matrix4x4(rows: (Vector4D(0, 0, 0, 0), Vector4D(0, 0, 0, 0), Vector4D(0, 0, 0, 0), Vector4D(0, 0, 0, 0))))
        #expect(Matrix4x4.identity == Matrix4x4(rows: (Vector4D(1, 0, 0, 0), Vector4D(0, 1, 0, 0), Vector4D(0, 0, 1, 0), Vector4D(0, 0, 0, 1))))
        #expect(Matrix4x4(diagonal: Vector4D(1, 2, 3, 4)) == Matrix4x4(rows: (Vector4D(1, 0, 0, 0), Vector4D(0, 2, 0, 0), Vector4D(0, 0, 3, 0), Vector4D(0, 0, 0, 4))))
    }

    @Test func transpose() {
        #expect(a.transpose == Matrix4x4(rows: (Vector4D(1, 0, 2, 1), Vector4D(2, 1, 4, 0), Vector4D(0, 3, 1, 0), Vector4D(1, 0, 2, 2))))
    }

    @Test func determinant() {
        #expect(a.determinant == 1)
        #expect(a.transpose.determinant == 1)
        #expect(Matrix4x4(diagonal: Vector4D(1, 2, 3, 4)).determinant == 24)
        #expect(b.determinant == 0)
    }

    @Test func inverse() {
        #expect(a.inverse == Matrix4x4(rows: (Vector4D(-22, -4, 12, -1), Vector4D(6, 1, -3, 0), Vector4D(-2, 0, 1, 0), Vector4D(11, 2, -6, 1))))
        #expect(a * a.inverse == .identity)
        #expect(a.inverse * a == .identity)
    }

    @Test func singularInverse() {
        #expect(!Matrix4x4.zero.inverse[0, 0].isFinite)
    }

    @Test func matrixMultiplication() {
        #expect(a * b == Matrix4x4(rows: (Vector4D(24, 28, 32, 36), Vector4D(32, 36, 40, 44), Vector4D(57, 66, 75, 84), Vector4D(27, 30, 33, 36))))
        #expect(b * a == Matrix4x4(rows: (Vector4D(11, 16, 9, 15), Vector4D(27, 44, 25, 35), Vector4D(43, 72, 41, 55), Vector4D(59, 100, 57, 75))))
        #expect(a * .identity == a)
    }

    @Test func vectorMultiplication() {
        let vector = Vector4D(1, 2, 3, 4)
        #expect(a * vector == Vector4D(9, 11, 21, 9))
        #expect(vector * a == Vector4D(11, 16, 9, 15))
        #expect(vector * a == a.transpose * vector)
    }

    @Test func addition() {
        #expect(a + b == Matrix4x4(rows: (Vector4D(2, 4, 3, 5), Vector4D(5, 7, 10, 8), Vector4D(11, 14, 12, 14), Vector4D(14, 14, 15, 18))))
    }

    @Test func subtraction() {
        #expect(b - a == Matrix4x4(rows: (Vector4D(0, 0, 3, 3), Vector4D(5, 5, 4, 8), Vector4D(7, 6, 10, 10), Vector4D(12, 14, 15, 14))))
    }

    @Test func negation() {
        #expect(-a == Matrix4x4(rows: (Vector4D(-1, -2, 0, -1), Vector4D(0, -1, -3, 0), Vector4D(-2, -4, -1, -2), Vector4D(-1, 0, 0, -2))))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Matrix4x4(rows: (Vector4D(2, 4, 0, 2), Vector4D(0, 2, 6, 0), Vector4D(4, 8, 2, 4), Vector4D(2, 0, 0, 4))))
        #expect(2 * a == a * 2)
        #expect(a / 2 == Matrix4x4(rows: (Vector4D(0.5, 1.0, 0.0, 0.5), Vector4D(0.0, 0.5, 1.5, 0.0), Vector4D(1.0, 2.0, 0.5, 1.0), Vector4D(0.5, 0.0, 0.0, 1.0))))
    }

    @Test func compoundAssignment() {
        var matrix = a
        matrix += b
        matrix -= a
        #expect(matrix == b)
        matrix *= 2
        matrix /= 2
        #expect(matrix == b)
        matrix *= a
        #expect(matrix == b * a)
    }

    @Test func description() {
        #expect(a.description == "Matrix4x4(columns: (Vector4D(x: 1.0, y: 0.0, z: 2.0, w: 1.0), Vector4D(x: 2.0, y: 1.0, z: 4.0, w: 0.0), Vector4D(x: 0.0, y: 3.0, z: 1.0, w: 0.0), Vector4D(x: 1.0, y: 0.0, z: 2.0, w: 2.0)))")
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "[[1,0,2,1],[2,1,4,0],[0,3,1,0],[1,0,2,2]]")
        #expect(try JSONDecoder().decode(Matrix4x4.self, from: data) == a)
    }
}

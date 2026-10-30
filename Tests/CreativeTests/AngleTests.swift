import Foundation
import RealModule
import Testing
@testable import Creative

@Suite struct AngleTests {
    let a = Angle(radians: 1)
    let b = Angle(radians: 3)

    @Test func radians() {
        #expect(a.rawValue == 1)
        #expect(a.radians == 1)
        #expect(Angle.radians(1) == a)
        #expect(Angle(rawValue: 1) == a)
    }

    @Test func degrees() {
        #expect(Angle(degrees: 180).radians.isApproximatelyEqual(to: .pi))
        #expect(Angle.degrees(90) == Angle(degrees: 90))
        #expect(Angle(radians: .pi).degrees.isApproximatelyEqual(to: 180))
    }

    @Test func settingRadiansAndDegrees() {
        var angle = Angle.zero
        angle.radians = 1
        #expect(angle == a)
        angle.degrees = 180
        #expect(angle.radians.isApproximatelyEqual(to: .pi))
    }

    @Test func constants() {
        #expect(Angle.zero.radians == 0)
        #expect(Angle.quarterTurn.radians == .pi / 2)
        #expect(Angle.halfTurn.radians == .pi)
        #expect(Angle.fullTurn.radians == 2 * .pi)
    }

    @Test func noWrapping() {
        #expect(Angle.degrees(720).degrees.isApproximatelyEqual(to: 720))
        #expect(Angle.fullTurn != .zero)
    }

    @Test func addition() {
        #expect(a + b == Angle(radians: 4))
    }

    @Test func subtraction() {
        #expect(b - a == Angle(radians: 2))
    }

    @Test func compoundAdditionAndSubtraction() {
        var angle = a
        angle += b
        #expect(angle == Angle(radians: 4))
        angle -= b
        #expect(angle == a)
    }

    @Test func negation() {
        #expect(-a == Angle(radians: -1))
    }

    @Test func scalarMultiplicationAndDivision() {
        #expect(a * 2 == Angle(radians: 2))
        #expect(2 * a == a * 2)
        #expect(b / 3 == a)
    }

    @Test func compoundScalarMultiplicationAndDivision() {
        var angle = a
        angle *= 3
        #expect(angle == b)
        angle /= 3
        #expect(angle == a)
    }

    @Test func comparison() {
        #expect(a < b)
        #expect(-b < a)
        #expect(max(a, b) == b)
    }

    @Test func trigonometry() {
        #expect(sin(Angle.zero) == 0)
        #expect(cos(Angle.zero) == 1)
        #expect(sin(Angle.quarterTurn).isApproximatelyEqual(to: 1))
        #expect(cos(Angle.halfTurn).isApproximatelyEqual(to: -1))
        #expect(tan(Angle.degrees(45)).isApproximatelyEqual(to: 1))
    }

    @Test func description() {
        #expect(Angle.degrees(90).description == "90°")
        #expect(Angle.halfTurn.description == "180°")
        #expect(Angle.degrees(-22.5).description == "-22.5°")
    }

    @Test func debugDescription() {
        #expect(Angle.quarterTurn.debugDescription == "Angle(radians: 1.5707963)")
        #expect(Angle(radians: 1.5707963) == .quarterTurn)
    }

    @Test func codable() throws {
        let data = try JSONEncoder().encode(a)
        #expect(String(decoding: data, as: UTF8.self) == "1")
        #expect(try JSONDecoder().decode(Angle.self, from: data) == a)
    }
}

import XCTest
@testable import CalendarDate

final class ParserTests: XCTestCase {

    func testParseInt() throws {
        let parser = Parser(string: "12")
        let result = try parser.parseInt()
        XCTAssertEqual(result, 12)
    }

    func testParseIntWithLeadingZero() throws {
        let parser = Parser(string: "01")
        let result = try parser.parseInt()
        XCTAssertEqual(result, 1)
    }

    func testParseIntShouldRejectLeadingWhitespace() throws {
        let parser = Parser(string: " 12")
        XCTAssertThrowsError(try parser.parseInt()) { error in
            XCTAssertEqual(error.localizedDescription, "Unexpected character at index 0.")
        }
    }

    func testParseIntWithExpectedLength() throws {
        let parser = Parser(string: "123")
        let result = try parser.parseInt(expectedLength: 3)
        XCTAssertEqual(result, 123)
    }

    func testParseIntWithExpectedLengthShouldRejectWrongLength() throws {
        let parser = Parser(string: "123")
        XCTAssertThrowsError(try parser.parseInt(expectedLength: 2)) { error in
            XCTAssertEqual(error.localizedDescription, "Unexpected integer length at index 0.")
        }
    }

}

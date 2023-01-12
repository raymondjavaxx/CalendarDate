import XCTest
@testable import CalendarDate

final class CalendarTimeTests: XCTestCase {

    func testISO8601() {
        let date = CalendarTime(hour: 10, minute: 45, second: 0)
        XCTAssertEqual(date.iso8601(), "10:45:00")
    }

    func testComparingHour() {
        let earlier = CalendarTime(hour: 9, minute: 45, second: 0)
        let later = CalendarTime(hour: 10, minute: 45, second: 0)

        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingMinute() {
        let earlier = CalendarTime(hour: 10, minute: 44, second: 0)
        let later = CalendarTime(hour: 10, minute: 45, second: 0)

        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingSecond() {
        let earlier = CalendarTime(hour: 10, minute: 45, second: 0)
        let later = CalendarTime(hour: 10, minute: 45, second: 1)

        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingWithEqualValues() {
        let first = CalendarTime(hour: 10, minute: 45, second: 0)
        let second = CalendarTime(hour: 10, minute: 45, second: 0)

        XCTAssertEqual(first, second)
    }

    func testComparingWithDifferentValues() {
        let first = CalendarTime(hour: 10, minute: 45, second: 0)
        let second = CalendarTime(hour: 10, minute: 45, second: 1)

        XCTAssertNotEqual(first, second)
    }

    func testIsValid() {
        XCTAssertTrue(CalendarTime(hour: 0, minute: 0, second: 0).isValid)
        XCTAssertTrue(CalendarTime(hour: 23, minute: 59, second: 59).isValid)

        XCTAssertFalse(CalendarTime(hour: -1, minute: 0, second: 0).isValid)
        XCTAssertFalse(CalendarTime(hour: 0, minute: -1, second: 0).isValid)
        XCTAssertFalse(CalendarTime(hour: 0, minute: 0, second: -1).isValid)

        XCTAssertFalse(CalendarTime(hour: 24, minute: 59, second: 59).isValid)
        XCTAssertFalse(CalendarTime(hour: 23, minute: 60, second: 59).isValid)
        XCTAssertFalse(CalendarTime(hour: 23, minute: 59, second: 60).isValid)
    }

}

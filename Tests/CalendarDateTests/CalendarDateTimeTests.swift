import XCTest
@testable import CalendarDate

final class CalendarDateTimeTests: XCTestCase {

    func testISO8601() {
        let dateTime = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        XCTAssertEqual(dateTime.iso8601(), "2018-06-01T12:30:00")
    }

    func testComparingYears() {
        let earlier = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let later = CalendarDateTime(year: 2019, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingMonths() {
        let earlier = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let later = CalendarDateTime(year: 2018, month: 7, day: 1, hour: 12, minute: 30, second: 0)
        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingDays() {
        let earlier = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let later = CalendarDateTime(year: 2018, month: 6, day: 2, hour: 12, minute: 30, second: 0)
        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingHours() {
        let earlier = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let later = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 13, minute: 30, second: 0)
        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingMinutes() {
        let earlier = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let later = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 31, second: 0)
        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingSeconds() {
        let earlier = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let later = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 1)
        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingEqual() {
        let first = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let second = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        XCTAssertEqual(first, second)
    }

    func testComparingNotEqual() {
        let first = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 0)
        let second = CalendarDateTime(year: 2018, month: 6, day: 1, hour: 12, minute: 30, second: 1)
        XCTAssertNotEqual(first, second)
    }

}

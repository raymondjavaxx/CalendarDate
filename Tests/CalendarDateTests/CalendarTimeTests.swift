import XCTest
@testable import CalendarDate

class CalendarTimeTests: XCTestCase {

    func testISO8601() {
        let date = CalendarTime(hour: 10, minute: 45, second: 0)
        XCTAssertEqual(date.iso8601(), "10:45:00")
    }

    func testComparing() {
        let earlier = CalendarTime(hour: 10, minute: 45, second: 0)
        let later = CalendarTime(hour: 11, minute: 45, second: 0)
        XCTAssertTrue(later > earlier)
    }

    func testComparingWithEqualValues() {
        let first = CalendarTime(hour: 10, minute: 45, second: 0)
        let second = CalendarTime(hour: 10, minute: 45, second: 0)
        XCTAssertTrue(first == second)
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

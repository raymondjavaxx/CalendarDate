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
        let a = CalendarTime(hour: 10, minute: 45, second: 0)
        let b = CalendarTime(hour: 10, minute: 45, second: 0)
        XCTAssertTrue(a == b)
    }

}

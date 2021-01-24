import XCTest
@testable import CalendarDate

class CalendarDateTests: XCTestCase {

    func testISO8601() {
        let date = CalendarDate(year: 2018, month: 6, day: 1)
        XCTAssertEqual(date.iso8601(), "2018-06-01")
    }

    func testComparing() {
        let earlier = CalendarDate(year: 1955, month: 2, day: 24)
        let later = CalendarDate(year: 1955, month: 10, day: 28)
        XCTAssertTrue(later > earlier)
    }

    func testComparingWithEqualValues() {
        let first = CalendarDate(year: 2019, month: 11, day: 3)
        let second = CalendarDate(year: 2019, month: 11, day: 3)
        XCTAssertTrue(first == second)
    }

}

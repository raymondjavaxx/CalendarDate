import XCTest
@testable import CalendarDate

final class CalendarDateTests: XCTestCase {

    func testISO8601() {
        let date = CalendarDate(year: 2018, month: 6, day: 1)
        XCTAssertEqual(date.iso8601(), "2018-06-01")
    }

    func testComparingYear() {
        let earlier = CalendarDate(year: 2000, month: 10, day: 28)
        let later = CalendarDate(year: 2001, month: 10, day: 28)

        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingMonth() {
        let earlier = CalendarDate(year: 2001, month: 9, day: 28)
        let later = CalendarDate(year: 2001, month: 10, day: 28)

        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingDay() {
        let earlier = CalendarDate(year: 2001, month: 10, day: 27)
        let later = CalendarDate(year: 2001, month: 10, day: 28)

        XCTAssertLessThan(earlier, later)
        XCTAssertGreaterThan(later, earlier)
    }

    func testComparingWithEqualValues() {
        let first = CalendarDate(year: 2000, month: 11, day: 3)
        let second = CalendarDate(year: 2000, month: 11, day: 3)

        XCTAssertEqual(first, second)
    }

    func testComparingWithDifferentValues() {
        let first = CalendarDate(year: 2000, month: 11, day: 3)
        let second = CalendarDate(year: 2000, month: 11, day: 4)

        XCTAssertNotEqual(first, second)
    }

}

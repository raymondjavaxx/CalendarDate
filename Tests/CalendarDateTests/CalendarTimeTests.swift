import XCTest
@testable import CalendarDate

final class CalendarTimeTests: XCTestCase {

    func testISO8601() {
        let date = CalendarTime(hour: 10, minute: 45, second: 0)
        XCTAssertEqual(date.iso8601(), "10:45:00")
    }

    func testComparing() {
        // 10:45:34
        let reference = CalendarTime(hour: 10, minute: 45, second: 34)

        // Convert to seconds
        let referenceSeconds = reference.hour * 3600 + reference.minute * 60 + reference.second

        for seconds in 0..<referenceSeconds {
            let time = CalendarTime(
                hour: seconds / 3600,
                minute: (seconds % 3600) / 60,
                second: seconds % 60
            )

            XCTAssertTrue(time < reference, "\(time.iso8601()) should be < \(reference.iso8601())")
        }

        for seconds in referenceSeconds..<86400 {
            let time = CalendarTime(
                hour: seconds / 3600,
                minute: (seconds % 3600) / 60,
                second: seconds % 60
            )

            XCTAssertFalse(time < reference, "\(time.iso8601()) should be >= \(reference.iso8601())")
        }
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

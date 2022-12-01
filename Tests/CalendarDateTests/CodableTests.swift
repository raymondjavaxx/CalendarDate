import XCTest
@testable import CalendarDate

final class CodableTests: XCTestCase {
    struct MockEvent: Codable {
        let date: CalendarDateTime
        let timezone: String
    }

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    func testDecoding() throws {
        let json = """
            {"date": "2019-11-05T10:45:00", "timezone": "America/New_York"}
        """

        let event = try decoder.decode(MockEvent.self, from: try XCTUnwrap(json.data(using: .utf8)))

        XCTAssertEqual(event.date, CalendarDateTime(year: 2019, month: 11, day: 5, hour: 10, minute: 45))
    }

    func testEncoding() throws {
        let event = MockEvent(
            date: CalendarDateTime(year: 2019, month: 11, day: 5, hour: 10, minute: 45),
            timezone: "America/New_York"
        )

        let data = try encoder.encode(event)
        let json = try XCTUnwrap(String(data: data, encoding: .utf8))

        XCTAssertTrue(json.contains("2019-11-05T10:45:00"))
    }

}

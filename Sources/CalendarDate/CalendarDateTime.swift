//
//  CalendarDateTime.swift
//  CalendarDate
//
//  Copyright (c) 2019 Ramon Torres
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// Groups CalendarDate and CalendarTime to represent a date + time.
public struct CalendarDateTime {

    /// The date component of the date + time.
    public let date: CalendarDate

    /// The time component of the date + time.
    public let time: CalendarTime

    /// Whether or not the date + time is valid.
    public var isValid: Bool {
        return date.isValid && time.isValid
    }

    /// Creates a new `CalendarDateTime`.
    ///
    /// - Parameters:
    ///   - year: The year component of the date.
    ///   - month: The month component of the date.
    ///   - day: The day component of the date.
    ///   - hour: The hour component of the time.
    ///   - minute: The minute component of the time.
    ///   - second: The second component of the time.
    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int = 0) {
        self.init(
            date: CalendarDate(year: year, month: month, day: day),
            time: CalendarTime(hour: hour, minute: minute, second: second)
        )
    }

    /// Creates a new `CalendarDateTime`.
    ///
    /// - Parameters:
    ///   - date: The date component of the date + time.
    ///   - time: The time component of the date + time.
    public init(date: CalendarDate, time: CalendarTime) {
        self.date = date
        self.time = time
    }

    /// Converts the CalendarDateTime to a Swift date.
    ///
    /// - Parameters:
    ///     - timezone: The timezone to use when coverting to `Date`.
    ///         Defaults to current timezone.
    public func asDate(timezone: TimeZone = .current) -> Date {
        let components = DateComponents(
            calendar: .gregorian,
            timeZone: timezone,

            year: date.year,
            month: date.month,
            day: date.day,

            hour: time.hour,
            minute: time.minute,
            second: time.second
        )

        guard let date = Calendar.gregorian.date(from: components) else {
            preconditionFailure("Invalid date-time")
        }

        return date
    }

    /// Returns the ISO 8601 representation of the calendar date-time
    public func iso8601() -> String {
        return "\(date.iso8601())T\(time.iso8601())"
    }

}

extension CalendarDateTime: Comparable {

    public static func < (lhs: CalendarDateTime, rhs: CalendarDateTime) -> Bool {
        return (lhs.date, lhs.time) < (rhs.date, rhs.time)
    }

    public static func == (lhs: CalendarDateTime, rhs: CalendarDateTime) -> Bool {
        return (
            lhs.date == rhs.date &&
            lhs.time == rhs.time
        )
    }

}

extension CalendarDateTime: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        let parser = Parser(string: rawValue)

        do {
            let date = try CalendarDate(from: parser) // NN-NN-NN
            try parser.parseString("T")               // T
            let time = try CalendarTime(from: parser) // NN:NN:NN
            self.init(date: date, time: time)
        } catch {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Invalid date-time format.",
                underlyingError: error
            ))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.iso8601())
    }

}

//
//  CalendarDate.swift
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

/// Represents a calendar date, such as a birthday.
public struct CalendarDate {

    public let year: Int
    public let month: Int
    public let day: Int

    public var isValid: Bool {
        return components.isValidDate
    }

    private var components: DateComponents {
        return DateComponents(calendar: .gregorian, year: year, month: month, day: day)
    }

    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }

    /// Converts the CalendarDate to a Swift `Date`.
    ///
    /// - Parameters:
    ///     - timezone: The timezone to use when coverting to `Date`.
    ///         Defaults to current timezone.
    public func asDate(timezone: TimeZone = .current) -> Date {
        let components = DateComponents(
            calendar: .gregorian,
            timeZone: timezone,

            year: year,
            month: month,
            day: day
        )

        guard let date = Calendar.gregorian.date(from: components) else {
            preconditionFailure("Invalid date")
        }

        return date
    }

    /// Returns the ISO 8601 representation of the calendar date.
    public func iso8601() -> String {
        return String(format: "%04d-%02d-%02d", year, month, day)
    }

}

extension CalendarDate: Comparable {

    public static func < (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return (
            lhs.year  < rhs.year  ||
            lhs.month < rhs.month ||
            lhs.day   < rhs.day
        )
    }

    public static func == (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return (
            lhs.year  == rhs.year  &&
            lhs.month == rhs.month &&
            lhs.day   == rhs.day
        )
    }

}

extension CalendarDate {

    internal init(from parser: Parser) throws {
        let year = try parser.parseInt()  // NN
        try parser.parseString("-")       // -
        let month = try parser.parseInt() // NN
        try parser.parseString("-")       // -
        let day = try parser.parseInt()   // NN
        self.init(year: year, month: month, day: day)
    }

}

extension CalendarDate: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        do {
            try self.init(from: Parser(string: rawValue))
        } catch {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Invalid date format.",
                underlyingError: error
            ))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.iso8601())
    }

}

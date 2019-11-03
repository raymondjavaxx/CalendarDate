//
//  CalendarTime.swift
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

public struct CalendarTime {

    public let hour: Int
    public let minute: Int
    public let second: Int

    public var isValid: Bool {
        return (
            hour   >= 0 && hour   <= 23 &&
            minute >= 0 && minute <= 59 &&
            second >= 0 && hour   <= 59
        )
    }

    public init(hour: Int, minute: Int, second: Int) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    public func asDate() -> Date {
        let components = DateComponents(
            calendar: .gregorian,
            timeZone: .current,
            hour: hour,
            minute: minute,
            second: second
        )

        guard let date = Calendar.gregorian.date(from: components) else {
            preconditionFailure("Invalid date")
        }

        return date
    }

    public func iso8601() -> String {
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }

}

extension CalendarTime: Comparable {

    public static func < (lhs: CalendarTime, rhs: CalendarTime) -> Bool {
        return (
            lhs.hour   < rhs.hour   ||
            lhs.minute < rhs.minute ||
            lhs.second < rhs.second
        )
    }

    public static func == (lhs: CalendarTime, rhs: CalendarTime) -> Bool {
        return (
            lhs.hour   == rhs.hour   &&
            lhs.minute == rhs.minute &&
            lhs.second == rhs.second
        )
    }

}

extension CalendarTime {

    internal init(from parser: Parser) throws {
        let hour = try parser.parseInt()   // NN
        try parser.parseString(":")        // :
        let minute = try parser.parseInt() // NN
        try parser.parseString(":")        // :
        let second = try parser.parseInt() // NN
        self.init(hour: hour, minute: minute, second: second)
    }

}

extension CalendarTime: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        do {
            try self.init(from: Parser(string: rawValue))
        } catch {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Invalid time format.",
                underlyingError: error
            ))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.iso8601())
    }

}

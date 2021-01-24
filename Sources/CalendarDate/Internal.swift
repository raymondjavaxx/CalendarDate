//
//  Internal.swift
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

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

enum ParsingError: Error {
    case unexpectedCharacter
}

class Parser {

    private let scanner: Scanner

    init(string: String) {
        self.scanner = Scanner(string: string)
    }

    func parseInt() throws -> Int {
        var result: Int = 0

        guard scanner.scanInt(&result) else {
            throw ParsingError.unexpectedCharacter
        }

        return result
    }

    func parseString(_ searchString: String) throws {
        guard scanner.scanString(searchString, into: nil) else {
            throw ParsingError.unexpectedCharacter
        }
    }

}

//
//  Parser.swift
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

enum ParsingError: Error {
    case unexpectedCharacter(index: Int)
    case unexpectedIntLength(index: Int)
}

extension ParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unexpectedCharacter(let index):
            return "Unexpected character at index \(index)."
        case .unexpectedIntLength(let index):
            return "Unexpected integer length at index \(index)."
        }
    }
}

final class Parser {

    private let scanner: Scanner

    init(string: String) {
        self.scanner = Scanner(string: string)
        // `Scanner` will skip whitespace by default, so we need to disable that.
        self.scanner.charactersToBeSkipped = nil
    }

    func parseInt(expectedLength: Int? = nil) throws -> Int {
        let initialLocation = scanner.scanLocation

        var result: Int = 0

        guard scanner.scanInt(&result) else {
            throw ParsingError.unexpectedCharacter(index: scanner.scanLocation)
        }

        if let expectedLength = expectedLength {
            let length = scanner.scanLocation - initialLocation
            guard length == expectedLength else {
                throw ParsingError.unexpectedIntLength(index: initialLocation)
            }
        }

        return result
    }

    func parseString(_ searchString: String) throws {
        guard scanner.scanString(searchString, into: nil) else {
            throw ParsingError.unexpectedCharacter(index: scanner.scanLocation)
        }
    }

}

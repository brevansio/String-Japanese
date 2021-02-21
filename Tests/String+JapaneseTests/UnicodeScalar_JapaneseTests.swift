//
//  UnicodeScalar_JapaneseTests.swift
//  
//
//  Created by Bruce Evans on 2021/02/21.
//

import XCTest
@testable import String_Japanese

final class UnicodeScalar_JapaneseTests: XCTestCase {
    func testIsHiragana() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertTrue(scalar.isHiragana)

        scalar = "ア"
        XCTAssertFalse(scalar.isHiragana)

        scalar = "分"
        XCTAssertFalse(scalar.isHiragana)

        scalar = "A"
        XCTAssertFalse(scalar.isHiragana)

        scalar = " "
        XCTAssertFalse(scalar.isHiragana)

        scalar = "　"
        XCTAssertFalse(scalar.isHiragana)

        scalar = "。"
        XCTAssertFalse(scalar.isHiragana)

        scalar = "、"
        XCTAssertFalse(scalar.isHiragana)
    }

    func testIsKatakana() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isKatakana)

        scalar = "ア"
        XCTAssertTrue(scalar.isKatakana)

        scalar = "分"
        XCTAssertFalse(scalar.isKatakana)

        scalar = "A"
        XCTAssertFalse(scalar.isKatakana)

        scalar = " "
        XCTAssertFalse(scalar.isKatakana)

        scalar = "　"
        XCTAssertFalse(scalar.isKatakana)

        scalar = "。"
        XCTAssertFalse(scalar.isKatakana)

        scalar = "、"
        XCTAssertFalse(scalar.isKatakana)
    }

    func testIsKanji() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isKanji)

        scalar = "ア"
        XCTAssertFalse(scalar.isKanji)

        scalar = "分"
        XCTAssertTrue(scalar.isKanji)

        scalar = "A"
        XCTAssertFalse(scalar.isKanji)

        scalar = " "
        XCTAssertFalse(scalar.isKanji)

        scalar = "　"
        XCTAssertFalse(scalar.isKanji)

        scalar = "。"
        XCTAssertFalse(scalar.isKanji)

        scalar = "、"
        XCTAssertFalse(scalar.isKanji)
    }

    func testIsKuten() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isKuten)

        scalar = "ア"
        XCTAssertFalse(scalar.isKuten)

        scalar = "分"
        XCTAssertFalse(scalar.isKuten)

        scalar = "A"
        XCTAssertFalse(scalar.isKuten)

        scalar = " "
        XCTAssertFalse(scalar.isKuten)

        scalar = "　"
        XCTAssertFalse(scalar.isKuten)

        scalar = "。"
        XCTAssertTrue(scalar.isKuten)

        scalar = "、"
        XCTAssertFalse(scalar.isKuten)
    }

    func testIsTouten() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isTouten)

        scalar = "ア"
        XCTAssertFalse(scalar.isTouten)

        scalar = "分"
        XCTAssertFalse(scalar.isTouten)

        scalar = "A"
        XCTAssertFalse(scalar.isTouten)

        scalar = " "
        XCTAssertFalse(scalar.isTouten)

        scalar = "　"
        XCTAssertFalse(scalar.isTouten)

        scalar = "。"
        XCTAssertFalse(scalar.isTouten)

        scalar = "、"
        XCTAssertTrue(scalar.isTouten)
    }

    func testIsJASpace() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isJASpace)

        scalar = "ア"
        XCTAssertFalse(scalar.isJASpace)

        scalar = "分"
        XCTAssertFalse(scalar.isJASpace)

        scalar = "A"
        XCTAssertFalse(scalar.isJASpace)

        scalar = " "
        XCTAssertFalse(scalar.isJASpace)

        scalar = "　"
        XCTAssertTrue(scalar.isJASpace)

        scalar = "。"
        XCTAssertFalse(scalar.isJASpace)

        scalar = "、"
        XCTAssertFalse(scalar.isJASpace)
    }

    func testIsFullWidthLatin() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "ア"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "分"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "A"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = " "
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "　"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "。"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "、"
        XCTAssertFalse(scalar.isFullWidthLatin)

        scalar = "ａ"
        XCTAssertTrue(scalar.isFullWidthLatin)
    }

    func testIsFullWidthNumerical() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "ア"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "分"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "A"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = " "
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "　"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "。"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "、"
        XCTAssertFalse(scalar.isFullWidthNumerical)

        scalar = "３"
        XCTAssertTrue(scalar.isFullWidthNumerical)
    }

    func testIsJASpecific() throws {
        var scalar: UnicodeScalar = "あ"
        XCTAssertTrue(scalar.isJASpecific)

        scalar = "ア"
        XCTAssertTrue(scalar.isJASpecific)

        scalar = "分"
        XCTAssertFalse(scalar.isJASpecific)

        scalar = "A"
        XCTAssertFalse(scalar.isJASpecific)

        scalar = " "
        XCTAssertFalse(scalar.isJASpecific)

        scalar = "　"
        XCTAssertFalse(scalar.isJASpecific)

        scalar = "。"
        XCTAssertFalse(scalar.isJASpecific)

        scalar = "、"
        XCTAssertFalse(scalar.isJASpecific)

        scalar = "ゝ"
        XCTAssertTrue(scalar.isJASpecific)
    }

    static var allTests = [
        ("testIsHiragana", testIsHiragana),
        ("testIsKatakana", testIsKatakana),
        ("testIsKanji", testIsKanji),
        ("testIsKuten", testIsKuten),
        ("testIsTouten", testIsTouten),
        ("testIsJASpace", testIsJASpace),
        ("testIsFullWidthLatin", testIsFullWidthLatin),
        ("testIsFullWidthNumerical", testIsFullWidthNumerical),
        ("testIsJASpecific", testIsJASpecific),
    ]
}

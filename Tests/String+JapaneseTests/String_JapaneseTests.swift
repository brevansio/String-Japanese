import XCTest
@testable import String_Japanese

final class String_JapaneseTests: XCTestCase {
    func testJapaneseType() throws {
        var string = "abcde"
        XCTAssertEqual(string.japaneseType(), .unknown)

        string = "わかります"
        XCTAssertEqual(string.japaneseType(), .hiragana)

        string = "ワカリマス"
        XCTAssertEqual(string.japaneseType(), .katakana)

        string = "分"
        XCTAssertEqual(string.japaneseType(), .kanji)

        string = "わカリマス"
        XCTAssertEqual(string.japaneseType(), .compound)

        string = "分かります"
        XCTAssertEqual(string.japaneseType(), .compound)

        string = "分カリマス"
        XCTAssertEqual(string.japaneseType(), .compound)
    }

    func testContainsJapaneseText() throws {
        var string = "wakarimasu"
        XCTAssertFalse(string.containsJapaneseText())

        string = "わかります"
        XCTAssertTrue(string.containsJapaneseText())

        string = "ワカリマス"
        XCTAssertTrue(string.containsJapaneseText())

        string = "分"
        XCTAssertTrue(string.containsJapaneseText())

        string = "I わかります"
        XCTAssertTrue(string.containsJapaneseText())

        string = "I ワカリマス"
        XCTAssertTrue(string.containsJapaneseText())

        string = "I 分かります"
        XCTAssertTrue(string.containsJapaneseText())
    }

    func testJapaneseToRomaji() throws {
        var string = "wakarimasu"
        XCTAssertEqual(string.japaneseToRomaji(), "wakarimasu")

        string = "わかります"
        XCTAssertEqual(string.japaneseToRomaji(), "wakarimasu")

        string = "ワカリマス"
        XCTAssertEqual(string.japaneseToRomaji(), "wakarimasu")

        string = "分"
        XCTAssertEqual(string.japaneseToRomaji(), "bun")

        string = "Iわかります"
        XCTAssertEqual(string.japaneseToRomaji(), "Iwakarimasu")

        string = "Iワカリマス"
        XCTAssertEqual(string.japaneseToRomaji(), "Iwakarimasu")

        string = "I分かります"
        XCTAssertEqual(string.japaneseToRomaji(), "Iwakarimasu")

        /// NOTE: Due to the word identification used, the Japanese root is separated from the postfix
        /// i.e. wakari (stem) + masu (postfix)
        /// This test may fail in future Swift releases if the word parser is changed
        string = "Iわかります"
        XCTAssertEqual(string.japaneseToRomaji(separator: " "), "I wakari masu")

        string = "Iワカリマス"
        XCTAssertEqual(string.japaneseToRomaji(separator: " "), "I wakari masu")

        string = "I分かります"
        XCTAssertEqual(string.japaneseToRomaji(separator: " "), "I wakari masu")
    }

    func testJapaneseToHiragana() throws {
        var string = "wakarimasu"
        XCTAssertEqual(string.japaneseToHiragana(), "わかります")

        string = "わかります"
        XCTAssertEqual(string.japaneseToHiragana(), "わかります")

        string = "ワカリマス"
        XCTAssertEqual(string.japaneseToHiragana(), "わかります")

        string = "分"
        XCTAssertEqual(string.japaneseToHiragana(), "ぶん")

        string = "Iわかります"
        XCTAssertEqual(string.japaneseToHiragana(), "いわかります")

        string = "Iワカリマス"
        XCTAssertEqual(string.japaneseToHiragana(), "いわかります")

        string = "I分かります"
        XCTAssertEqual(string.japaneseToHiragana(), "いわかります")
    }

    func testJapaneseToKatakana() throws {
        var string = "wakarimasu"
        XCTAssertEqual(string.japaneseToKatakana(), "ワカリマス")

        string = "わかります"
        XCTAssertEqual(string.japaneseToKatakana(), "ワカリマス")

        string = "ワカリマス"
        XCTAssertEqual(string.japaneseToKatakana(), "ワカリマス")

        string = "分"
        XCTAssertEqual(string.japaneseToKatakana(), "ブン")

        string = "Iわかります"
        XCTAssertEqual(string.japaneseToKatakana(), "イワカリマス")

        string = "Iワカリマス"
        XCTAssertEqual(string.japaneseToKatakana(), "イワカリマス")

        string = "I分かります"
        XCTAssertEqual(string.japaneseToKatakana(), "イワカリマス")
    }

    func testRomajiToHiragana() throws {
        let string = "wakarimasu"
        XCTAssertEqual(string.romajiToHiragana(), "わかります")
    }

    func testRomajiToKatakana() throws {
        let string = "wakarimasu"
        XCTAssertEqual(string.romajiToKatakana(), "ワカリマス")
    }

    func testKanjiToHiragana() throws {
        let string = "分"
        XCTAssertEqual(string.kanjiToHiragana(), "ぶん")
    }

    func testKanjiToKatakana() throws {
        let string = "分"
        XCTAssertEqual(string.kanjiToKatakana(), "ブン")
    }

    static var allTests = [
        ("testJapaneseType", testJapaneseType),
        ("testContainsJapaneseText", testContainsJapaneseText),
        ("testJapaneseToRomaji", testJapaneseToRomaji),
        ("testJapaneseToHiragana", testJapaneseToHiragana),
        ("testJapaneseToKatakana", testJapaneseToKatakana),
        ("testRomajiToHiragana", testRomajiToHiragana),
        ("testRomajiToKatakana", testRomajiToKatakana),
        ("testKanjiToHiragana", testKanjiToHiragana),
        ("testKanjiToKatakana", testKanjiToKatakana),
    ]
}

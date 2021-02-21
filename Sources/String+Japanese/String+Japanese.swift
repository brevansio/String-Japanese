//
//  String+Japanese.swift
//  
//
//  Created by Bruce Evans on 2021/02/21.
//

import Foundation
import CoreFoundation

extension String {
    public enum JapaneseType {
        case hiragana
        case katakana
        case kanji
        case compound
        case unknown
    }

    public func japaneseType() -> JapaneseType {
        var characterClass: UnicodeScalar.JAClassification?
        for scalar in unicodeScalars {
            let classification = scalar.jaClassification

            if let lastCharacterClass = characterClass {
                if lastCharacterClass != classification {
                    if classification == .katakana || classification == .hiragana || classification == .kanji {
                        return .compound
                    }
                    return .unknown
                }
            } else {
                characterClass = classification
            }
        }

        switch characterClass {
        case .hiragana:
            return .hiragana
        case .katakana:
            return .katakana
        case .kanji:
            return .kanji
        case .none, .space, .kuten, .touten, .fullWidthlatin, .other:
            return .unknown
        }
    }

    public func containsJapaneseText() -> Bool {
        for scalar in unicodeScalars {
            if scalar.isJASpecific || scalar.isKanji {
                return true
            }
        }
        return false
    }

    public func japaneseToRomaji(separator: Character? = nil) -> String {
        var latinString = ""

        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault,
                                                self as CFString,
                                                CFRangeMake(0, self.utf16.count),
                                                kCFStringTokenizerUnitWord,
                                                CFLocaleCreate(kCFAllocatorDefault, CFLocaleIdentifier("Japanese" as CFString)))

        var result = CFStringTokenizerAdvanceToNextToken(tokenizer)

        while (result.rawValue != 0) {
            if let attribute = CFStringTokenizerCopyCurrentTokenAttribute(tokenizer, kCFStringTokenizerAttributeLatinTranscription),
               let attributeString = attribute as? String {
                if let separator = separator {
                    latinString += String(separator)
                }
                latinString += String(format: "%@", attributeString)
            } else {
                let range = CFStringTokenizerGetCurrentTokenRange(tokenizer)
                if range.location == kCFNotFound
                    && range.location + range.length < CFStringGetLength(self as CFString),
                   let unmodifiedString = CFStringCreateWithSubstring(kCFAllocatorDefault, self as CFString, range) {
                    if let separator = separator {
                        latinString += String(separator)
                    }
                    latinString += unmodifiedString as String
                }
            }

            result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }

        // A leading separator is added. Trim it off.
        if let separator = separator {
            latinString = latinString.trimmingCharacters(in: CharacterSet(charactersIn: String(separator)))
        }
        return latinString
    }

    public func japaneseToHiragana() -> String {
        japaneseToRomaji().transliterate(with: kCFStringTransformLatinHiragana)
    }

    public func japaneseToKatakana() -> String {
        japaneseToRomaji().transliterate(with: kCFStringTransformLatinKatakana)
    }

    public func romajiToHiragana() -> String {
        transliterate(with: kCFStringTransformLatinHiragana)
    }

    public func romajiToKatakana() -> String {
        transliterate(with: kCFStringTransformLatinKatakana)
    }

    public func kanjiToHiragana() -> String {
        var kanjiFreeString = ""

        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault,
                                                self as CFString,
                                                CFRangeMake(0, self.utf16.count),
                                                kCFStringTokenizerUnitWord,
                                                CFLocaleCreate(kCFAllocatorDefault, CFLocaleIdentifier("Japanese" as CFString)))

        var result = CFStringTokenizerAdvanceToNextToken(tokenizer)

        while (result.rawValue != 0) {
            let range = CFStringTokenizerGetCurrentTokenRange(tokenizer)

            let utf16Array = self.utf16.map { $0 }
            let subArray = Array(utf16Array[range.location..<(range.location + range.length)])
            let subString = String(utf16CodeUnits: subArray, count: subArray.count)

            let type = subString.japaneseType()
            if type == .kanji || type == .compound {
                kanjiFreeString += subString.japaneseToHiragana()
            } else {
                kanjiFreeString += subString
            }

            result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }

        return kanjiFreeString
    }

    public func kanjiToKatakana() -> String {
        var kanjiFreeString = ""

        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault,
                                                self as CFString,
                                                CFRangeMake(0, self.utf16.count),
                                                kCFStringTokenizerUnitWord,
                                                CFLocaleCreate(kCFAllocatorDefault, CFLocaleIdentifier("Japanese" as CFString)))

        var result = CFStringTokenizerAdvanceToNextToken(tokenizer)

        while (result.rawValue != 0) {
            let range = CFStringTokenizerGetCurrentTokenRange(tokenizer)

            let utf16Array = self.utf16.map { $0 }
            let subArray = Array(utf16Array[range.location..<(range.location + range.length)])
            let subString = String(utf16CodeUnits: subArray, count: subArray.count)

            let type = subString.japaneseType()
            if type == .kanji || type == .compound {
                kanjiFreeString += subString.japaneseToKatakana()
            } else {
                kanjiFreeString += subString
            }

            result = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }

        return kanjiFreeString
    }

    private func transliterate(with transform: CFString) -> String {
        guard let mutableString = CFStringCreateMutableCopy(kCFAllocatorDefault, 0, self as CFString) else {
            return self
        }

        guard CFStringTransform(mutableString, nil, transform, false) else {
            return self
        }

        return mutableString as String
    }
}


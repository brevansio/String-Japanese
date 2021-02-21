//
//  UnicodeScalar+Japanese.swift
//  
//
//  Created by Bruce Evans on 2021/02/21.
//

import Foundation

extension UnicodeScalar {
    public var isHiragana: Bool {
        return (0x3040...0x309F).contains(value)
    }

    public var isKatakana: Bool {
        return ((0x30A0...0x30FF).contains(value) && value != 0x30FB) || (0xFF66...0xFF9F).contains(value)
    }

    public var isKanji: Bool {
        return (0x2E80...0x2EFF).contains(value) || (0x2F00...0x2FDF).contains(value)
            || (0x4E00...0x9FAF).contains(value) || value == 0x3005
    }

    public var isKuten: Bool {
        return [0x3002, 0xFF61, 0xFF0E].contains(value)
    }

    public var isTouten: Bool {
        return [0x3001, 0xFF64, 0xFF0C].contains(value)
    }

    public var isJASpace: Bool {
        return value == 0x3000
    }

    public var isFullWidthLatin: Bool {
        return (0xFF01...0xFF5E).contains(value)
    }

    public var isFullWidthNumerical: Bool {
        return (0xFF10...0xFF19).contains(value)
    }

    public var isJASpecific: Bool {
        return (0x3040...0x30FF).contains(value) || (0xFF01...0xFF9F).contains(value)
    }
}

extension UnicodeScalar {
    enum JAClassification {
        case space, hiragana, katakana, kanji, kuten, touten, fullWidthlatin, other
    }

    var jaClassification: JAClassification {
        if isHiragana {
            return .hiragana
        } else if isKatakana {
            return .katakana
        } else if isKanji {
            return .kanji
        } else if isKuten {
            return .kuten
        } else if isTouten {
            return .touten
        } else if isJASpace {
            return .space
        } else if isFullWidthLatin || isFullWidthNumerical {
            return .fullWidthlatin
        } else {
            return .other
        }
    }
}

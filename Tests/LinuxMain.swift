import XCTest

import String_JapaneseTests

var tests = [XCTestCaseEntry]()
tests += String_JapaneseTests.allTests()
tests += UnicodeScalar_JapaneseTests.allTests()
XCTMain(tests)

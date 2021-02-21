import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(String_JapaneseTests.allTests),
        testCase(UnicodeScalar_JapaneseTests.allTests),
    ]
}
#endif

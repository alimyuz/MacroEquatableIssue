import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import MyMacroMacros

let testMacros: [String: Macro.Type] = [
    "myMacro": MyMacro.self,
]

final class MyMacroTests: XCTestCase {
    func testMacro() {
        assertMacroExpansion(
            """
            class Example {
                @myMacro
                func foo() {
                }
            }
            """,
            expandedSource:
            """
            class Example {
                func foo() {
                }
            }
            """,
            macros: testMacros
        )
    }
}

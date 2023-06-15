import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension String: Error {
    
}

public struct MyMacro: PeerMacro {
    public static func expansion<Context, Declaration>(
        of node: AttributeSyntax,
        providingPeersOf declaration: Declaration,
        in context: Context
    ) throws -> [DeclSyntax] where Context : MacroExpansionContext, Declaration : DeclSyntaxProtocol {
        guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
            return []
        }
        
        let retrievedAttribute = funcDecl.attributes?.compactMap { attributeSyntax in
            switch attributeSyntax {
            case .attribute(let attribute):
                return attribute
            default:
                return nil
            }
        }.first
        
        if retrievedAttribute != node {
            context.addDiagnostics(from: "retrievedAttribute != node", node: node)
        }
        if retrievedAttribute!.id != node.id {
            context.addDiagnostics(from: "retrievedAttribute!.id != node.id", node: node)
        }
        
        return []
    }
}

@main
struct MyMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MyMacro.self,
    ]
}

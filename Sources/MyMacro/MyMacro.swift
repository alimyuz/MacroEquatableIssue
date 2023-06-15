@attached(peer, names: arbitrary)
public macro myMacro() = #externalMacro(module: "MyMacroMacros", type: "MyMacro")

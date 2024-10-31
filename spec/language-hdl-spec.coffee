# If you want an example of language specs, check out:
# https://github.com/atom/language-javascript/blob/master/spec/javascript-spec.coffee

describe "Hdl grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-hdl")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.hdl")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.hdl"
    
  it "highlights comments", ->
    result = grammar.tokenizeLine("// This is a comment")
    expect(result).toEqual([{ scopes: ["comment.hdl"], text: "// This is a comment" }])

    result = grammar.tokenizeLine("/* This is a\nmultiline comment */")
    expect(result).toEqual([{ scopes: ["comment.hdl"], text: "/* This is a\nmultiline comment */" }])

  it "highlights address labels", ->
    result = grammar.tokenizeLine("@label1")
    expect(result).toEqual([{ scopes: ["variable.addressLabel.hdl"], text: "@label1" }])

  it "highlights address variables", ->
    result = grammar.tokenizeLine("@R0")
    expect(result).toEqual([{ scopes: ["variable.address.hdl"], text: "@R0" }])

    result = grammar.tokenizeLine("@SCREEN")
    expect(result).toEqual([{ scopes: ["variable.address.hdl"], text: "@SCREEN" }])

  it "highlights keywords", ->
    result = grammar.tokenizeLine("load")
    expect(result).toEqual([{ scopes: ["keywords.hdl"], text: "load" }])

  it "highlights chips", ->
    result = grammar.tokenizeLine("CHIP MyChip")
    expect(result).toEqual([{ scopes: ["chip.hdl"], text: "CHIP MyChip" }])

  it "highlights variables", ->
    result = grammar.tokenizeLine("fVar")
    expect(result).toEqual([{ scopes: ["variable.hdl"], text: "fVar" }])

  it "highlights function definitions", ->
    result = grammar.tokenizeLine("functionName(arg1, arg2)")
    expect(result).toEqual([{ scopes: ["function.hdl", "definition.start.hdl"], text: "functionName(arg1, arg2)" }])

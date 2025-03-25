// using regex as typechecking
open System.Text.RegularExpressions

type NumberRegex = | NumberRegex of string

// This acts as a typechecker
let makeNumberRegex (x: string) =
    let number = new Regex("^\d+$")
    match number.IsMatch(x) with
        | true -> NumberRegex x
        | false -> invalidArg x "Expected number-string"

// Generic version
let regexCheckType regextype regex (x: string) =
    let checker = new Regex(regex)
    match checker.IsMatch(x) with
        | true -> regextype x
        | false -> invalidArg x ("Expected argument matching type-regex " + regex)

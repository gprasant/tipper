// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var myVariable = 42;

myVariable = 50;

let myConstant = 43;

let explicitDouble: Double = 70

let label = "The width is "

let width = 94

let message = label + String(width)

let apples = 3
let oranges=5
let appleMessage = "I have \(apples) apples"
let fruitMessage = "I have \(apples + oranges) fruits"

let name = "Prasanth"
let greetingMessage = "Hello \(name)"

let computationMsg = "The value is \(40.5)"

var alphabets = ["a", "a", "c", "d"]
alphabets[1] = "b"

var responsibilities = [
    "walter": "product",
    "jessie": "distribution"
]

responsibilities["saul"] = "legal"

print(responsibilities)

var optionalName: String? = nil
var greeting = "Hello! "

if let name = optionalName {
    greeting = "Hello, \(name)"
}
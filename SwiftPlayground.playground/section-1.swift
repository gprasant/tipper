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

let vegetable = "red pepper"

switch vegetable {
    case "celery":
        let comment = "the vegetable is a celery stick. Not so tasty"
    case "pumpkin", "melon":
        let comment = "is it halloween yet ?"
    default:
        let comment = "everything tastes good in soup."
}

let interestingNumbers = [
    "prime": [2, 3, 5, 7, 11, 13],
    "fibonacci": [1, 1, 2, 3, 5, 8],
    "squares": [1, 4 ,9, 16, 25]
]
var maximum = 0;
for (name, numbers) in interestingNumbers {
    for (n) in numbers {
        if (n > maximum) {
            maximum = n
        }
    }
}
maximum

//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    var horizontalPosition = 0
    var depth = 0
    
    lines.forEach { line in
        let (direction, steps) = parseLine(line)
        switch direction {
        case .forward:
            horizontalPosition += steps
        case .up:
            depth -= steps
        case .down:
            depth += steps
        }
    }
    
    print(horizontalPosition * depth)
}

enum Direction: String {
    case forward
    case up
    case down
}

func parseLine(_ line: String) -> (direction: Direction, steps: Int) {
    let helper = RegexHelper(pattern: #"([\w]*)\s(\d+)"#)
    let result = helper.parse(line)
    let direction = Direction(rawValue: result[0])!
    let steps = Int(result[1])!
    return (direction: direction, steps: steps)
}

main()

//
//  struct organizer.swift
//  mcg
//
//  Created by Bernardo on 26/07/24.
//

import Foundation

struct Person: Identifiable {
    let id = UUID()
    var name: String
    var age: Int
    var yearsLeft: Int {
        return 90 - age
    }
}

let people: [Person] = [
    Person(name: "Alice", age: 25),
    Person(name: "Bob", age: 30),
    Person(name: "Charlie", age: 28),
    Person(name: "David", age: 32),
    Person(name: "Eve", age: 27),
]

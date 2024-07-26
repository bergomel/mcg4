//
//  mcgApp.swift
//  mcg
//
//  Created by Bernardo on 11/06/24.
//

import SwiftUI

@main
struct mcgApp: App {
    var body: some Scene {
        WindowGroup {
            TestContentView(selectedPerson: Person(name: "Alice", age: 25), selectedPersonID: UUID())
        }
    }
}

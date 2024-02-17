//
//  project12App.swift
//  project12
//
//  Created by Christian Rubio on 2/17/24.
//

import SwiftUI

@main
struct project12App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}

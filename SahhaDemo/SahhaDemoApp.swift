// Copyright © 2022 Sahha. All rights reserved.

import SwiftUI
import Sahha

@main
struct SahhaDemoApp: App {
    
    init() {
        let settings = SahhaSettings(environment: .development)
        Sahha.configure(settings)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



import SwiftUI

@main 
struct SetGameApp: App {
    private let game = ViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView()
        }
    }
}

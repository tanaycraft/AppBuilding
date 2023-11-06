//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Tanay Patil on 10/17/22.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var manager = PListManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(manager)
        }
    }
}

//
//  mapappApp.swift
//  mapapp
//
//  Created by Map Mac on 09/10/2023.
//

import SwiftUI

@main
struct mapappApp: App {
    
    @StateObject private var locationsVM = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(locationsVM)
        }
    }
}

//
//  MemeCreatorApp.swift
//  MemeCreator
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

@main
struct MemeCreatorApp: App {
    @StateObject private var fetcher = PandaCollectionFetcher()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MemeView()
                    .environmentObject(fetcher)
            }
        }
    }
}

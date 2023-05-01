//
//  DataFlowApp.swift
//  DataFlow
//
//  Created by Mehmet Tarhan on 01/05/2023.
//

import SwiftUI

@main
struct DataFlowApp: App {
    @StateObject private var recipeBox = RecipeBox(recipes: load("recipeData.json"))
    @State private var selectedSidebarItem: SidebarItem? = SidebarItem.all
    @State private var selectedRecipeId: Recipe.ID?

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView(selection: $selectedSidebarItem, recipeBox: recipeBox)
            } content: {
                ContentListView(selection: $selectedRecipeId, selectedSidebarItem: selectedSidebarItem ?? SidebarItem.all)
            } detail: {
                DetailView(recipeId: $selectedRecipeId)
            }
            .environmentObject(recipeBox)
        }
    }
}

//
//  ContentListView.swift
//  DataFlow
//
//  Created by Mehmet Tarhan on 01/05/2023.
//

import SwiftUI

struct ContentListView: View {
    @Binding var selection: Recipe.ID?
    let selectedSidebarItem: SidebarItem
    @EnvironmentObject private var recipeBox: RecipeBox

    /*
     The recipeEditorConfig declaration includes the attribute for the State property wrapper, which tells SwiftUI to create and manage the instance of RecipeEditorConfig.
     Each time view state changes, that is, data that recipeEditorConfig contains changes, SwiftUI reinitializes the view,
     reconnects the RecipeEditorConfig instance to the view, and rebuilds the view defined in the computed body property, which reflects the current state of the data.
     */
    @State private var recipeEditorConfig = RecipeEditorConfig()

    var body: some View {
        RecipeListView(selection: $selection, selectedSidebarItem: selectedSidebarItem)
            .navigationTitle(selectedSidebarItem.title)
            .toolbar {
                ToolbarItem {
                    Button {
                        recipeEditorConfig.presentAddRecipe(sidebarItem: selectedSidebarItem)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $recipeEditorConfig.isPresented,
                           onDismiss: didDismissEditor) {
                        RecipeEditor(config: $recipeEditorConfig)
                    }
                }
            }
    }

    private func didDismissEditor() {
        if recipeEditorConfig.shouldSaveChanges {
            if recipeEditorConfig.recipe.isNew {
                selection = recipeBox.add(recipeEditorConfig.recipe)
            } else {
                recipeBox.update(recipeEditorConfig.recipe)
            }
        }
    }
}

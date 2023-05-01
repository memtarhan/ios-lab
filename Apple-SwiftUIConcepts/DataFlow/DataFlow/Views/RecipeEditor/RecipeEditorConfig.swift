//
//  RecipeEditorConfig.swift
//  DataFlow
//
//  Created by Mehmet Tarhan on 01/05/2023.
//

import SwiftUI

/*
 The structure RecipeEditorConfig stores the state data that the RecipeEditor view needs.
 To trigger state changes that happen in the RecipeEditor view, RecipeEditorConfig provides mutating functions that update the data to reflect a new state.
 */

struct RecipeEditorConfig {
    var recipe = Recipe.emptyRecipe()
    var shouldSaveChanges = false
    var isPresented = false

    /*
     Changes the state of the view to indicate that its editing a new recipe.
     The app calls this method when a person taps the Add Recipe button.
     */

    mutating func presentAddRecipe(sidebarItem: SidebarItem) {
        recipe = Recipe.emptyRecipe()

        switch sidebarItem {
        case .favorites:
            // Associate the recipe to the favorites collection.
            recipe.isFavorite = true
        case let .collection(name):
            // Associate the recipe to a custom collection.
            recipe.collections = [name]
        default:
            // Nothing else to do.
            break
        }

        shouldSaveChanges = false
        isPresented = true
    }

    mutating func presentEditRecipe(_ recipeToEdit: Recipe) {
        recipe = recipeToEdit
        shouldSaveChanges = false
        isPresented = true
    }

    mutating func done() {
        shouldSaveChanges = true
        isPresented = false
    }

    mutating func cancel() {
        shouldSaveChanges = false
        isPresented = false
    }
}

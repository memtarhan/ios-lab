//
//  RecipeEditor.swift
//  DataFlow
//
//  Created by Mehmet Tarhan on 01/05/2023.
//

import SwiftUI

struct RecipeEditor: View {
    /*
     The Binding property wrapper provides a two-way, read-write binding to data that the view needs.
     However, RecipeEditor doesn’t own the data. Instead, another view creates and owns the instance of RecipeEditorConfig that RecipeEditor binds to and uses.
     */
    @Binding var config: RecipeEditorConfig

    var body: some View {
        NavigationStack {
            /*
             RecipeEditor passes the binding variable config to RecipeEditorForm.
             It passes the variable as a binding, indicated by prefixing the variable name config with the $ symbol.
             Because RecipeEditorForm receives config as a binding, the form can read and write data to config.
             */
            RecipeEditorForm(config: $config)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(editorTitle)
                    }

                    ToolbarItem(placement: cancelButtonPlacement) {
                        Button {
                            config.cancel()
                        } label: {
                            Text("Cancel")
                        }
                    }

                    ToolbarItem(placement: saveButtonPlacement) {
                        Button {
                            config.done()
                        } label: {
                            Text("Save")
                        }
                    }
                }
            #if os(macOS)
                .padding()
            #endif
        }
    }

    private var editorTitle: String {
        config.recipe.isNew ? "Add Recipe" : "Edit Recipe"
    }

    private var cancelButtonPlacement: ToolbarItemPlacement {
        #if os(macOS)
            .cancellationAction
        #else
            .navigationBarLeading
        #endif
    }

    private var saveButtonPlacement: ToolbarItemPlacement {
        #if os(macOS)
            .confirmationAction
        #else
            .navigationBarTrailing
        #endif
    }
}

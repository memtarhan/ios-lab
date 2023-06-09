//
//  RecipeListItemView.swift
//  DataFlow
//
//  Created by Mehmet Tarhan on 01/05/2023.
//

import SwiftUI

struct RecipeListItemView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            recipe.smallImage
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(4)
            
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.title3)
                Text(recipe.subtitle)
                    .font(.caption)
            }
            
            Spacer()
            
            if recipe.isFavorite {
                Image(systemName: "heart")
                    .symbolVariant(.fill)
            }
        }
    }
}


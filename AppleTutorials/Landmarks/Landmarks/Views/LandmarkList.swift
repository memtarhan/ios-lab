//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 27/04/2023.
//

import SwiftUI

struct LandmarkList: View {
    /*
     The modelData property gets its value automatically, as long as the environmentObject(_:) modifier has been applied to a parent.
     */
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            !showFavoritesOnly || landmark.isFavorite
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                /*
                 To combine static and dynamic views in a list, or to combine two or more different groups of dynamic views, use the ForEach type instead of passing your collection of data to List.
                 */
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}

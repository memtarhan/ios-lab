//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 27/04/2023.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
        .listStyle(.plain)
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}

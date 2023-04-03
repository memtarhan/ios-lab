//
//  CalorieView.swift
//  SwiftUIWithUIKit
//
//  Created by Mehmet Tarhan on 03/04/2023.
//

import SwiftUI

struct CalorieData: Identifiable {
    let id: UUID
    let date: Date
    let count: Int
}

extension CalorieData {
    static func generateRandomData(days: Int) -> [CalorieData] {
        var data = [CalorieData]()
        let today = Date()
        for index in 0 ..< days {
            let date = Calendar.current.date(byAdding: .day, value: -index, to: today)!
            let count = Int.random(in: 500 ... 25000)
            data.append(CalorieData(id: UUID(), date: date, count: count))
        }
        return data
    }
}

struct CalorieView: View {
    var data: CalorieData

    @State private var isExpanded = false
    private var expandButtonImage: Image? {
        isExpanded ? Image(systemName: "chevron.up") : Image(systemName: "chevron.down")
    }

    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(data.date, format: .dateTime.weekday())
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
                    .font(.system(.title3, weight: .bold).uppercaseSmallCaps())
                    .frame(minWidth: 50)
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text(data.count, format: .number)
                        .foregroundStyle(.primary)
                        .font(.system(.title, weight: .semibold))
                        .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                    Spacer()
                    Text("calories")
                        .foregroundStyle(.orange)
                        .font(.system(.subheadline, weight: .bold))
                }
                Button {
                    isExpanded.toggle()
                } label: {
                    expandButtonImage
                }
            }
            
            if isExpanded {
                HStack {
                    Image(systemName: "figure.walk.circle.fill")
                    Image(systemName: "figure.walk.circle.fill")
                    Image(systemName: "figure.walk.circle.fill")
                    Image(systemName: "figure.walk.circle.fill")
                }
            }
        }
    }
}

struct CalorieView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(CalorieData.generateRandomData(days: 30)) { data in
                CalorieView(data: data)
            }
        }
    }
}

//
//  CaloriesViewController.swift
//  SwiftUIWithUIKit
//
//  Created by Mehmet Tarhan on 03/04/2023.
//

import SwiftUI
import UIKit

private enum CalorieSection: Int, CaseIterable {
    case calories
}

private struct StaticData {
    lazy var calories = CalorieData.generateRandomData(days: 30)
}

class CaloriesViewController: UIViewController, UICollectionViewDataSource {
    // The static data being displayed by this view controller.
    private var data = StaticData()

    // The collection view which will display the custom cells.
    private var collectionView: UICollectionView!

    override func loadView() {
        setUpCollectionView()
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Calories"
        view.maximumContentSizeCategory = .extraExtraExtraLarge
    }

    // Creates the collection view with a compositional layout, which contains multiple sections of different layouts.
    private func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, layoutEnvironment in
            switch CalorieSection(rawValue: sectionIndex)! {
            case .calories:
                return createListSection(layoutEnvironment)
            }
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.allowsSelection = false
        collectionView.dataSource = self
    }

    // Returns a compositional layout section for cells in a list.
    private func createListSection(_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.contentInsets = .zero
        section.contentInsets.leading = LayoutMetrics.horizontalMargin
        section.contentInsets.trailing = LayoutMetrics.horizontalMargin
        section.contentInsets.bottom = LayoutMetrics.sectionSpacing
        return section
    }

    private struct LayoutMetrics {
        static let horizontalMargin = 16.0
        static let sectionSpacing = 10.0
        static let cornerRadius = 10.0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CalorieSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch CalorieSection(rawValue: section)! {
        case .calories:
            return data.calories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CalorieSection(rawValue: indexPath.section)! {
        case .calories:
            let item = data.calories[indexPath.item]
            return collectionView.dequeueConfiguredReusableCell(using: calorieCellRegistration, for: indexPath, item: item)
        }
    }

    // A cell registration that configures a custom list cell with a SwiftUI calorie view.
    private var calorieCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, CalorieData> = {
        .init { cell, _, item in
            cell.contentConfiguration = UIHostingConfiguration {
                CalorieView(data: item)
            }
        }
    }()
}

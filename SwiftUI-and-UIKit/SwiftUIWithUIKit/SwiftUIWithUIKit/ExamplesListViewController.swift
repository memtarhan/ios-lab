//
//  ExamplesListViewController.swift
//  SwiftUIWithUIKit
//
//  Created by Mehmet Tarhan on 01/04/2023.
//

import SwiftUI
import UIKit

private struct MenuItem {
    var title: String
    var subtitle: String
    var viewControllerProvider: () -> UIViewController

    static let allExamples: [MenuItem] = []
}

class ExamplesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var collectionView: UICollectionView!

    override func loadView() {
        setUpCollectionView()
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Examples"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        deselectSelectedItem(animated)
    }

    private func deselectSelectedItem(_ animated: Bool) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }

        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.collectionView.deselectItem(at: indexPath, animated: true)
            }, completion: { context in
                if context.isCancelled {
                    self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                }
            })
        } else {
            collectionView.deselectItem(at: indexPath, animated: animated)
        }
    }

    private func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            let listConfig = UICollectionLayoutListConfiguration(appearance: .plain)
            let layoutSection = NSCollectionLayoutSection.list(using: listConfig, layoutEnvironment: layoutEnvironment)
            return layoutSection
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, MenuItem> = {
        .init { cell, _, item in
            cell.accessories = [.disclosureIndicator()]
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.secondaryText = item.subtitle
            content.secondaryTextProperties.color = .secondaryLabel
            cell.contentConfiguration = content
        }
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MenuItem.allExamples.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = MenuItem.allExamples[indexPath.item]
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    }

    func collectionView(_ collectionView: UICollectionView, performPrimaryActionForItemAt indexPath: IndexPath) {
        let item = MenuItem.allExamples[indexPath.item]
        let viewController = item.viewControllerProvider()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

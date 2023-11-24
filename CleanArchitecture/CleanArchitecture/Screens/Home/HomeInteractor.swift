//
//  HomeInteractor.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import Foundation

protocol HomeInteractor {
    var presenter: HomePresenter! { get set }
    
    func load()
}

class HomeInteractorImplementation: HomeInteractor {
    weak var presenter: HomePresenter!
    
    func load() {
        /// - Retrive some data
        presenter.display(items: (0 ... 10).map { "Item #\($0 + 1)" })
    }
}

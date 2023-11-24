//
//  HomePresenter.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import Combine
import Foundation

protocol HomePresenter: AnyObject {
    var loadedPublisher: AnyPublisher<[String], Error> { get }

    func display(items: [String])
}

// MARK: - Publishers

class HomePresenterImplementation: HomePresenter {
    var loadedPublisher: AnyPublisher<[String], Error> {
        loaded.eraseToAnyPublisher()
    }

    private var loaded = PassthroughSubject<[String], Error>()
}

// MARK: - Presenting Logic

extension HomePresenterImplementation {
    func display(items: [String]) {
        /// - Do some magic with received data
        loaded.send(items)
    }
}

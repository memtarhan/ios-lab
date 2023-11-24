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
}

class HomePresenterImplementation: HomePresenter {
    var loadedPublisher: AnyPublisher<[String], Error> {
        loaded.eraseToAnyPublisher()
    }

    private var loaded = PassthroughSubject<[String], Error>()
}

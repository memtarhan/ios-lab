//
//  HomeConfigurator.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import Foundation
import Swinject

class HomeConfigurator: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewController.self) { resolver in
            let view = HomeViewControllerImplementation.instantiate()
            var interactor = resolver.resolve(HomeInteractor.self)!
            let presenter = resolver.resolve(HomePresenter.self)!

            view.interactor = interactor
            view.presenter = presenter
            interactor.presenter = presenter 

            return view
        }

        container.register(HomeInteractor.self) { _ in
            HomeInteractorImplementation()
        }
        
        container.register(HomePresenter.self) { _ in
            HomePresenterImplementation()
        }
    }
}

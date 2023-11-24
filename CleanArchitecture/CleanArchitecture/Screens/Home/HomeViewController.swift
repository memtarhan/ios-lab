//
//  HomeViewController.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import Combine
import UIKit

protocol HomeViewController: BaseViewController {
    var interactor: HomeInteractor! { get set }
    var presenter: HomePresenter! { get set }
}

class HomeViewControllerImplementation: UIViewController, HomeViewController {
    var interactor: HomeInteractor!
    var presenter: HomePresenter!

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubscribers()

        interactor.load()
    }
}

// MARK: - Setup

private extension HomeViewControllerImplementation {
    func setupSubscribers() {
        presenter.loadedPublisher
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    break
                }
            } receiveValue: { data in
                print(data)
            }
            .store(in: &cancellables)
    }
}

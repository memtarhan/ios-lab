//
//  ViewControllerFactory.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import Foundation
import Swinject

protocol ScreenFactory: AnyObject {
    var home: HomeViewController { get }
}

class ScreenFactoryImplementation: ScreenFactory {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    var home: HomeViewController { assembler.resolver.resolve(HomeViewController.self)! }
}

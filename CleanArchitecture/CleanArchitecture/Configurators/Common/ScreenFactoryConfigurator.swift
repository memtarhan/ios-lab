//
//  ScreenFactoryConfigurator.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import Foundation
import Swinject

class ScreenFactoryConfigurator: Assembly {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    func assemble(container: Container) {
        container.register(ScreenFactory.self) { _ in
            ScreenFactoryImplementation(assembler: self.assembler)
        }
    }
}

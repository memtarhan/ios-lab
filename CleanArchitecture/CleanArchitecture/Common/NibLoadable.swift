//
//  NibLoadable.swift
//  CleanArchitecture
//
//  Created by Mehmet Tarhan on 24/11/2023.
//

import UIKit

protocol NibLoadable {
    static func instantiate() -> Self
}

extension NibLoadable where Self: UIViewController {
    /**
     Instantiates a view controller from a nib with the same name
     */
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let actualName = className.replacingOccurrences(of: "Implementation", with: "")

        return Self(nibName: actualName, bundle: nil)
    }
}

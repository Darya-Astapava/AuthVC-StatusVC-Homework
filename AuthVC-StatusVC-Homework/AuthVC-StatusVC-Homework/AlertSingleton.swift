//
//  AlertSingleton.swift
//  AuthVC-StatusVC-Homework
//
//  Created by Дарья Астапова on 5.02.21.
//

import UIKit

class AlertSingleton {
    // MARK: - Static property
    // Create static property to call it later how class object for call func.
    static var shared = AlertSingleton()
    
    // MARK: - Initializations
    private init() {}
    
    // MARK: - Methods
    func show(for controller: UIViewController,
              title: String = "",
              buttonStyle: UIAlertAction.Style = .cancel) {
        let allertController = UIAlertController(title: title,
                                                 message: nil,
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Ok",
                                                 style: buttonStyle,
                                                 handler: nil))
        controller.present(allertController, animated: true)
    }
}

extension AlertSingleton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

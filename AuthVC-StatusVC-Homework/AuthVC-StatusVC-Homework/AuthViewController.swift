//
//  ViewController.swift
//  AuthVC-StatusVC-Homework
//
//  Created by Дарья Астапова on 3.02.21.
//

import UIKit

class AuthViewController: UIViewController, SendingDataDelegate {
    
    // MARK: - Variables
    // Pass data with Notification Center
    // Step 1: create static property with Notification name to use it in posting data and adding observers later.
    static let notificationName = Notification.Name("usersData")
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Methods
    // Pass data with instance property and instanse method through segue.
    // Step 1: create a segue on storyboard between ViewControllers and add segue identifier.
    // Step 3: override func prepare. Check identifier, create a property with destination view controller type and apply value to needed properties and methods.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStatusVC",
           let destinationVC = segue.destination as? StatusViewController,
           let name = self.nameTextField.text,
           let password = self.passwordTextField.text {
            destinationVC.name = name
            destinationVC.getStatus(name: name, password: password)
            
            // Pass data with delegate. Step 4: subscribe to delegate
            destinationVC.delegate = self
            
            // Pass data with closure. Step 3: Get data from closure and use
            destinationVC.closure = { [weak self] status in
                guard let self = self else { return }
                self.infoLabel.isHidden = false
                self.infoLabel.text = status == "confirmed"
                    ? "Добро пожаловать, \(name)"
                    : "Ошибка"
                self.infoLabel.textColor = status == "confirmed"
                    ? .blue
                    : .orange
            }
        }
    }
    
    // Pass data with delegate. Step 3: The function required by protocol
    func changeBackgroundColor(status: StatusViewController.RegisterStatus) {
        self.view.backgroundColor = status.getColour(status: status)
    }
    
    // Pass data with Notification Center. Step 5: create func with changes for observer.
    @objc private func showAlert(notification: Notification) {
        var message: String = ""
        var style: UIAlertAction.Style = .cancel
        
        if let userInfo = notification.userInfo,
           let status = userInfo["Status"] as? String {
            message = status == "confirmed"
                ? "Вы успешно зарегистрировались"
                : "Регистрация не удалась"
            style = status == "confirmed"
                ? .cancel
                : .destructive
        }
        // Added alert.
        AlertSingleton.shared.show(for: self,
                                   title: message,
                                   buttonStyle: style)
    }
    
    // MARK: - Life Cycle
    // Pass data with Notification Center
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Step 3: add observer to accept notification. Pass the method to selector to will be executed when notification was accepted.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.showAlert),
                                               name: AuthViewController.notificationName,
                                               object: nil)
    }
    
    // Step 4: remove observer when not needed
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: AuthViewController.notificationName,
                                                  object: nil)
    }
}


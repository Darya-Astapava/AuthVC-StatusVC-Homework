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
    
    // Pass data with instance property and instanse method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStatusVC",
           let destinationVC = segue.destination as? StatusViewController,
           let name = self.nameTextField.text,
           let password = self.passwordTextField.text {
            destinationVC.name = name
            destinationVC.getStatus(name: name, password: password)
            destinationVC.delegate = self // Subscribe to delegate
            destinationVC.closure = { [weak self] status in // Get data from closure
                guard let self = self else { return }
                self.infoLabel.isHidden = false
                if status == "Confirmed" {
                    self.infoLabel.text = "Добро пожаловать, \(name)"
                    self.infoLabel.textColor = .blue
                } else {
                    self.infoLabel.text = "Ошибка"
                    self.infoLabel.textColor = .orange
                }
            }
        }
    }
    
    // Pass data with delegate. The function required by protocol
    func changeBackgroundColor(status: StatusViewController.RegisterStatus) {
        switch status {
        case .Confirmed:
            self.view.backgroundColor = .green
        case .Declined:
            self.view.backgroundColor = .red
        }
    }
    
    // Pass data with Notification Center
    // Step 5: create func with changes for observer.
    @objc private func showAlert(notification: Notification) {
        var message: String = ""
        var style: UIAlertAction.Style = .cancel
        
        if let userInfo = notification.userInfo,
           let status = userInfo["Status"] as? String {
            if status == "Confirmed" {
                message = "Вы успешно зарегистрировались"
            } else {
                message = "Регистрация не удалась"
                style = .destructive
            }
        }
        
        let allertController = UIAlertController(title: message,
                                                 message: nil,
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Ok",
                                                 style: style,
                                                 handler: nil))
        self.present(allertController, animated: true, completion: nil)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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


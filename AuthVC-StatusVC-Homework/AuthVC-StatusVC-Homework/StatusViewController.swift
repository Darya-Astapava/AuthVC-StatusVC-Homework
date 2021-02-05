//
//  StatusViewController.swift
//  AuthVC-StatusVC-Homework
//
//  Created by Дарья Астапова on 3.02.21.
//

import UIKit

class StatusViewController: UIViewController {
    // MARK: - Enums
    enum RegisterStatus: String {
        case confirmed
        case declined
        
        func getColour(status: RegisterStatus) -> UIColor {
            return status == .confirmed ? .green : .red
        }
    }
    
    // MARK: - Variables
    // Pass data with instance property. Step 2: create a property who will receive data.
    var name: String = ""
    
    var status: RegisterStatus?
    
    // Pass data with closures. Step 1: create optional property with describing type of the closure.
    var closure: ((String) -> Void)?
    
    // Pass data with delegate. Step 1: create optional property with type of protocol name 
    weak var delegate: SendingDataDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func pressCloseButton(_ sender: Any) {
        // Close StatusVC and go to the AuthVC
        self.dismiss(animated: true) { [weak self] in
            guard let self = self,
                  let status = self.status else { return }
            
            // Pass data with delegate. Step 5: realize required methods and properties
            self.delegate?.changeBackgroundColor(status: status)
            
            // Pass data with Notification Center
            // Step 2: Post data in Notification Center and pass data in userInfo parameter as dictionary.
            NotificationCenter.default.post(name: AuthViewController.notificationName,
                                            object: nil,
                                            userInfo: ["Status": status.rawValue])
            
            // Pass data with closure. Step 2: Add data to closure
            self.closure?(status.rawValue)
        }
    }
    
    // MARK: - Methods
    /// Define  status value with name and password symbols count
    func getStatus(name: String, password: String) {
        self.status = name.count + password.count >= 14
            ? .confirmed
            : .declined
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoLabel.text = name
    }
}

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
        case Confirmed
        case Declined
    }
    
    // MARK: - Variables
    var name: String = ""
    var status: RegisterStatus?
    var closure: ((String) -> Void)?
    weak var delegate: SendingDataDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func pressCloseButton(_ sender: Any) {
        // Close StatusVC and go to the AuthVC
        self.dismiss(animated: true) { [weak self] in
            guard let status = self?.status else { return }
            
            // Pass data with delegate
            self?.delegate?.changeBackgroundColor(status: status)
            
            // Pass data with Notification Center
            // Step 2: Post data in Notification Center and pass data in userInfo parameter as dictionary.
            NotificationCenter.default.post(name: AuthViewController.notificationName,
                                            object: nil,
                                            userInfo: ["Status": status.rawValue])
            
            // Pass data with closure
            // Add data to closure
            self?.closure?(status.rawValue)
        }
    }
    
    // MARK: - Methods
    
    /// Define  status value with name and password symbols count
    func getStatus(name: String, password: String) {
        if name.count + password.count >= 14 {
            self.status = .Confirmed
        } else {
            self.status = .Declined
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoLabel.text = name
    }
}

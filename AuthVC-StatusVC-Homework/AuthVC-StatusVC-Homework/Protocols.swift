//
//  Protocols.swift
//  AuthVC-StatusVC-Homework
//
//  Created by Дарья Астапова on 4.02.21.
//

import Foundation

// Pass data with delegate. Step 2: create protocol with required properties and methods. Protocol should be for classes only.
protocol SendingDataDelegate: class {
    func changeBackgroundColor(status: StatusViewController.RegisterStatus)
}

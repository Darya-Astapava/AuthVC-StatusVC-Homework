//
//  Protocols.swift
//  AuthVC-StatusVC-Homework
//
//  Created by Дарья Астапова on 4.02.21.
//

import Foundation

protocol SendingDataDelegate: class {
    func changeBackgroundColor(status: StatusViewController.RegisterStatus)
}

//
//  LoginModal.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import Foundation

// MARK: - LoginModal
struct LoginModal: Codable {
    var statusCode: Int?
    var message: String?
    var data: LoginData_Modal?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - LoginData_Modal
struct LoginData_Modal: Codable {
    var id: Int?
    var name, email: String?
    var userDevice: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case userDevice = "user_device"
    }
}

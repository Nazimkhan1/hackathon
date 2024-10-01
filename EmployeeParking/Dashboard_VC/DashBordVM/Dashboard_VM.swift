//
//  Dashboard_VM.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import UIKit

class Dashboard_VM: ObservableObject {
    
    @Published var dashboardData_Modal : DashboardData_Modal?
    
    func hitDashboard_API(_ success:@escaping(_ response: [DashboardData_Modal]?) -> Void) {
        
        
        Dashboard_APIServies.shared.dashboard_API() { result in
            if let response = result {
                success(response)
            }
        } failure: { failureMsg in
            success(nil)
            CommonUtils.showToast(message: failureMsg)
        }

        
    }
}


struct Dashboard_APIServies {
    public static let shared = Dashboard_APIServies()
     
    func dashboard_API(success: @escaping (_ result:[DashboardData_Modal]?) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
        
        APIManager.shared.callAPI(DashboardModal.self, apiName: .parkingList, postDict: [:], httpMethod: .GET) { responseModel, response, errorMessage in
            
            if errorMessage == nil {
                if let resData = responseModel?.data {
                    success(resData)
                }
            }else{
                failure("\(responseModel?.message ?? "Authentication failed !!!")")
            }
        }
    }
}

// MARK: - Welcome
struct DashboardModal: Codable {
    var statusCode: Int?
    var message: String?
    var data: [DashboardData_Modal]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DashboardData_Modal
struct DashboardData_Modal: Codable, Identifiable {
    var id: Int?
    var vehicleType, amount: String?
    var receiptFile: String?
    var createdAt, updatedAt: String?
    var userID: Int?
    var receiptDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case vehicleType = "vehicle_type"
        case amount
        case receiptFile = "receipt_file"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case receiptDate = "receipt_date"
    }
}


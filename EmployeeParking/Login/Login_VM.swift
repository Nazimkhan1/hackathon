//
//  Login_VM.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import Foundation

struct LoginParam_Request: Codable {
  var email: String?
  var password: String?
}

class Login_VM: ObservableObject {
    
    @Published var loginDataReponse:LoginData_Modal?
    
    func hitLogin_API(_ request:LoginParam_Request, success:@escaping(_ response: LoginData_Modal?) -> Void) {
        let postData = ["email":request.email ?? "",
                        "password":request.password ?? ""]
        
        Login_APIServies.shared.login_API(parameters: postData) { result in
            if let response = result {
                success(response)
            }
        } failure: { failureMsg in
            success(nil)
            CommonUtils.showToast(message: failureMsg)
        }

        
    }
}

public typealias FailureMessage = String
struct Login_APIServies {
    public static let shared = Login_APIServies()
     
    func login_API(parameters: [String:Any], success: @escaping (_ result: LoginData_Modal?) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
        
        APIManager.shared.callAPI(LoginModal.self, apiName: .login, postDict: parameters, httpMethod: .POST) { responseModel, response, errorMessage in
            
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

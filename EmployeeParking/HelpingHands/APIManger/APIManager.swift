//
//  APIManager.swift
//  DemoHackethon
//
//  Created by Pankaj Chauhan on 30/09/24.
//

import Foundation


// Enum for API Names
enum APIName: String {
    case login = "loginPost"
    case register = "registrationPost"
    case parkingList = "parkingList"
    // Add more cases as needed
}

// Enum for HTTP Methods
enum HTTPMethod: String {
    case GET
    case POST
    // Add more methods if needed
}

// Singleton Class for API Calls
class APIManager {
    
    // Shared instance for singleton
    static let shared = APIManager()
    
    // Private initializer to prevent instantiation from outside
    private init() {}
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // Generic API call function using NSURLSession
    func callAPI<T: Codable>(_ modelType: T.Type, apiName: APIName, postDict: [String: Any], httpMethod: HTTPMethod, completionHandler: @escaping (_ responseModel: T?,_ response: NSDictionary?, _ errorMessage: String?)-> Void
    ) {
        // Base URL
        let baseURL = "https://ba6c-2409-40e1-1140-b5e5-c0d2-5f26-97ee-20df.ngrok-free.app/api/"
        
        // Create the full URL string
        guard let url = URL(string: baseURL + apiName.rawValue) else {
            completionHandler(nil, nil, "Invalid URL")
            return
            
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        // If it's a POST request, encode the dictionary into JSON
        if httpMethod == .POST {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: postDict, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completionHandler(nil, nil, "Invalid parameters")
                return
            }
        }

        // Create the session and task
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Check for network errors
            if let error = error {
                completionHandler(nil, nil, error.localizedDescription)
                return
            }
            
            // Check if we got a valid response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                let errorResponse: NSDictionary = [
                    "status": (response as? HTTPURLResponse)?.statusCode ?? -1,
                    "message": "Server error or invalid response"
                ]
                completionHandler(nil, errorResponse, "Failed to connect to server")
                return
            }
            
            // Parse the JSON response into a dictionary
            do {

                let jsonDict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                
                decodeJSON(T.self, jsonDict as! Dict) { responsEE, erroRR in
                    
                    if let responsEE = responsEE
                    {
                        print("calling success")
                        completionHandler(responsEE,jsonDict as? NSDictionary, nil) }
                    else
                    {
                        print("calling failure")
                        completionHandler(nil, nil, nil) }
                }
            } catch {
                let errorResponse: NSDictionary = [
                    "status": httpResponse.statusCode,
                    "message": "Failed to parse JSON"
                ]
                completionHandler(nil, errorResponse, "Parsing error")
            }
        }
        
        task.resume()
    }
    
    
}

typealias Dict = [String: Any]
func decodeJSON<T: Codable>(_ model: T.Type,_ json: Dict, completion: @escaping(_ responsEE: T?,_ erroRR: String?) -> Void) {
    
    guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    else {
        completion(nil, commonMsg)
        return
    }
    
    do
    { _ = try JSONDecoder().decode(T.self, from: data) }
    catch
    { print("Decord Error -- \(error)") }
    
    guard let modelData = try? JSONDecoder().decode(T.self, from: data)
    else {
        completion(nil, commonMsg)
        return
    }
    
    completion(modelData, nil)
}
let commonMsg = "Something went wrong. Please try again later"

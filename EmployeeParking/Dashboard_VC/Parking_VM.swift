//
//  Parking_VM.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import UIKit


class Parking_VM: ObservableObject {
    
    @Published var loginDataReponse:LoginData_Modal?
    
    func uploadMultipart(
        url: URL,
        parameters: [String: Any], // For other form parameters
        image: UIImage, // The image to upload
        imageName: String, // The key for the image file
        fileName: String, // The file name for the uploaded image
        mimeType: String = "image/jpeg", // The mime type for the image
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Define boundary
        let boundary = UUID().uuidString
        
        // Set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create HTTP body
        let httpBody = createBodyWithParameters(parameters: parameters, image: image, boundary: boundary, imageName: imageName, fileName: fileName, mimeType: mimeType)
        
        // Set HTTP body
        request.httpBody = httpBody
        
        // Execute upload task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    private func createBodyWithParameters(parameters: [String: Any], image: UIImage, boundary: String, imageName: String, fileName: String, mimeType: String) -> Data {
        let body = NSMutableData()
        
        // Add parameters
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Add image data
        if let imageData = image.jpegData(compressionQuality: 0.7) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Add boundary end
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body as Data
    }
    
    
}



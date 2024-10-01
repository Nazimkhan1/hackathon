//
//  ContentView.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import SwiftUI

struct LoginView_VC: View {
    @State private var tf_Email = ""
    @State private var tf_Password = ""
    @State private var isLoggedIn = false
    @State private var isSignUp = false
    
    // State for validation error messages
    @State private var emailErrorMessage: String? = nil
    @State private var passwordErrorMessage: String? = nil
        
    @StateObject var login_VM = Login_VM()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image("login")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(.all)
                    .padding(.bottom, 200)
                
                VStack {
                    Spacer()
                    // Email TextField
                    TextField("Email", text: $tf_Email, onEditingChanged: { _ in
                        validateEmail()
                    })
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    
                    // Password SecureField
                    SecureField("Password", text: $tf_Password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                    // Show password error message
                    if let passwordError = passwordErrorMessage {
                        Text(passwordError)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.leading, 16)
                    }
                    HStack {
                        Text("Don't have an account?")
                            .padding()
                        // SignUp BUTTON
                        NavigationLink(destination: SignUp_VC(), isActive: $isSignUp) {
                            Text("Sign Up")
                                .padding(.leading, 5)
                                .foregroundColor(Color("themeColor"))
                        }
                                        
                    }
                    // LOGIN BUTTON
                    Button(action: {
                        print("Login tapped")
                        isLoggedIn = true
                       if validateForm() {
                           let loginParam_Request = LoginParam_Request(email:tf_Email,password:tf_Password)
                           login_VM.hitLogin_API(loginParam_Request) { response in
                               if response != nil {
                                   isLoggedIn = true
                               }else {
                                   print("API Reponse is Failed")
                                   isLoggedIn = true
                               }
                           }
                       }
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("themeColor"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .fullScreenCover(isPresented: $isLoggedIn){
                        Dashboard_VC()
                    }
                }
                .padding(.bottom, 20)
            }
            .onTapGesture {
                UIApplication.shared.endEditing(true)
            }
        }
        
    }
    
    
    func validateEmail() {
           // Check if the email is valid
           if tf_Email.isEmpty {
               emailErrorMessage = "Email is required"
           } else if !isValidateEmail(testStr: tf_Email){
               emailErrorMessage = "Invalid email format"
           } else {
               emailErrorMessage = nil // No error
           }
       }
       
       func validatePassword() {
           // Check if the password is at least 6 characters
           if tf_Password.isEmpty {
               passwordErrorMessage = "Password is required"
           }
//           else if !isValidPassword(testStr: tf_Password){
//               passwordErrorMessage = "Password should be contain 1 Special character 1 UpperCase 1 LowerCase 1 Number & Minimum 8 characters"
//           }
           else {
               passwordErrorMessage = nil // No error
           }
       }
       
       func validateForm() -> Bool {
           // Run individual validations
           validateEmail()
           validatePassword()
           
           // Return true if both fields are valid
           return emailErrorMessage == nil && passwordErrorMessage == nil
       }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView_VC()
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

func isValidateEmail(testStr:String) -> Bool {
    print("validate emilId: \(testStr)")
    let emailRegEx = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{0,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
}

func isValidPassword(testStr:String) -> Bool {
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
    let result = emailTest.evaluate(with: testStr)
    return result
}



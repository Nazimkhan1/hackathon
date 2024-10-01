//
//  SignUp_VC.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import SwiftUI

struct SignUp_VC: View {
    @State private var tf_Email = ""
    @State private var tf_Password = ""
    @State private var tf_Name = ""
    @State private var tf_MobileNumber = ""
    @State private var isSignUp = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image("login")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    // Email TextField
                    TextField("Name", text: $tf_Name)
                        .padding()
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                    TextField("Mobile Number", text: $tf_MobileNumber)
                        .padding()
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                    TextField("Email", text: $tf_Password)
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
                    HStack {
                        Text("Don't have an account?")
                            .padding()
                        // SignUp BUTTON
                        NavigationLink(destination: SignUp_VC(), isActive: $isSignUp) {
                            Text("Sign Up")
                                .padding(.leading,5)
                                .foregroundColor(Color("themeColor"))
                        }
                    }
                    // LOGIN BUTTON
                    Button(action: {
                        print("Sign Up tapped")
                        isSignUp = true
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("themeColor"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .fullScreenCover(isPresented: $isSignUp){
                        Dashboard_VC()
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp_VC()
    }
}


//
//  SplashView.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                LoginView_VC()
            } else {
                Image("login")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(.all)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

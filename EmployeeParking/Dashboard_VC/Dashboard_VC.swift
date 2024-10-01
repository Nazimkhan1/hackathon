//
//  Dashboard_VC.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import SwiftUI

struct Dashboard_VC: View {
    @State private var showVehiclePopup = false
    @State private var refreshMessage = "Dashboard not refreshed yet"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showVehiclePopup.toggle()
                            
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(Color("themeColor"))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                    
                }
                //                .navigationDestination(isPresented: $showVehiclePopup) {
                //                    VechicleTypeView {
                //                            self.refreshDashboard()
                //                    }
                //                }
                
                
                
            }
            .navigationTitle("Dashboard")
            .navigationBarItems(
                trailing: HStack {
                    // First button in navigation bar
                    Button(action: {
                        print("First button action")
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    
                    // Second button in navigation bar
                    Button(action: {
                        print("Second button action")
                    }) {
                        Image("logout")
                    }
                }
            )
            .background(
                NavigationLink(destination: VechicleTypeView {
                    self.refreshDashboard()
                }, isActive: $showVehiclePopup) {
                    EmptyView()
                }
            )
        }
    }
    
    // Completion handler to refresh dashboard
    func refreshDashboard() {
        self.refreshMessage = "Dashboard refreshed!"
    }
}


struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard_VC()
    }
}



struct VechicleTypeView: View {
    
//    @Binding var showPopup: Bool
    @State private var selectedVehicle: String = ""
    @State private var amount: String = "0"
    @State private var showParkingForm = false
    
    var onSuccess: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            if !showParkingForm {
                Text("Select Your Vehicle")
                    .font(.title)
                    .padding(.bottom, 20)
                
                // Vehicle selection buttons
                HStack(spacing: 50) {
                    Button(action: {
                        selectedVehicle = "3"
                        amount = "80" // Set amount for Car
                    }) {
                        Text("Car")
                            .padding()
                            .frame(width: 100, height: 50)
                            .background(selectedVehicle == "3" ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        selectedVehicle = "1"
                        amount = "40"
                    }) {
                        Text("Bike")
                            .padding()
                            .frame(width: 100, height: 50)
                            .background(selectedVehicle == "1" ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                // Confirm button
                Button(action: {
                    if !selectedVehicle.isEmpty {
                        showParkingForm = true
                    }
                }) {
                    Text("Confirm")
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            } else {
                // Show ParkingForm_View as a subview after confirming vehicle type
                
                ParkingForm_View(selectedVehicle: selectedVehicle, amount: $amount, onDismiss: {
//                    showPopup = false
                    onSuccess() // Callback to Dashboard_VC
                })
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }
}

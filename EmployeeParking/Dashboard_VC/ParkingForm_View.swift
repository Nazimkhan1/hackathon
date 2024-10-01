//
//  ParkingForm_View.swift
//  EmployeeParking
//
//  Created by Pankaj Chauhan on 01/10/24.
//

import SwiftUI

struct ParkingForm_View: View {
    
    var selectedVehicle: String
    @Binding var amount: String
    
    @StateObject var parkingVM = Parking_VM()
    
    @State private var tf_Amount = ""
    @State private var tf_Date = ""
    @State private var isParkingForm = false
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var dateButtonTitle = "Select Date"

    
    var onDismiss: () -> Void
    
    
    var body: some View {
        NavigationView {
            VStack{
                // Email TextField
                TextField("Amount", text:$amount)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                
                
                
                Button(action: {
                    showDatePicker.toggle() // Show the date picker when the button is tapped
                }) {
                    Text(dateButtonTitle) // Display the selected date or prompt text
                    
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, idealHeight: 50)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.leading,18)
                        .padding(.trailing,18)
                }
                .sheet(isPresented: $showDatePicker) {
                    DatePickerView(selectedDate: $selectedDate, dateButtonTitle: $dateButtonTitle, showDatePicker: $showDatePicker)
                }
                
                Button(action: {
                    
                }) {
                    Text("Upload Recepit")
                        .foregroundColor(.black)
                        .frame(height: 50)
                        .padding()
                        .cornerRadius(8)
                    Image(systemName: "doc.circle.fill")
                        .renderingMode(.template)
                        .foregroundStyle(Color("themeColor"))
                }
                .foregroundStyle(.black)
                .frame(height: 50)
                .padding(.horizontal, 16)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                
                Button(action: {
                    if validateForm() {
                        let url = URL(string: "https://ba6c-2409-40e1-1140-b5e5-c0d2-5f26-97ee-20df.ngrok-free.app/api/saveParkingBill")
                        let postData = ["user_id" : "1",
                                        "amount":amount,
                                        "vehicle_type":selectedVehicle
                        ]
                        if let image = UIImage(named: "splash") {
                            
                            parkingVM.uploadMultipart(url: url!, parameters: postData, image: image, imageName:"file" , fileName: "splash.png") { data in
                                onDismiss()
                                CommonUtils.showToast(message: "File Uploaded Successfully")
                            }
                        }
                    }
                }) {
                    Text("Upload Bill recepit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, idealHeight: 50)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)
                .cornerRadius(12)
            }
            .onTapGesture {
                onDismiss()
            }
            .navigationTitle("Choose your vehicle")
        }
    }
    
    func validateForm() -> Bool{
        return true
    }
}



struct DatePickerView: View {
    @Binding var selectedDate: Date // Binding to hold the selected date
    @Binding var dateButtonTitle: String // Binding to update the button title
    @Binding var showDatePicker: Bool // Binding to dismiss the date picker

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                Button(action: {
                    // Format the selected date for the button title
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd" // Set the desired date format
                    dateButtonTitle = formatter.string(from: selectedDate)
                    showDatePicker = false // Dismiss the date picker
                }) {
                    Text("Confirm Date")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Select Date")
            .navigationBarItems(trailing: Button("Done") {
                showDatePicker = false // Dismiss the date picker
            })
        }
    }
}

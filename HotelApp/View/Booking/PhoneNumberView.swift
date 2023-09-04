//
//  PhoneNumberView.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

struct PhoneNumberView: View {
    @Binding var phoneNumber: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 1) {
            Text("Номер телефона")
                .font(.caption)
                .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            TextField("+7(000) 000-00-00", text: $phoneNumber)
            
                .keyboardType(.numberPad)
                .onChange(of: phoneNumber, perform: { newValue in
                    if newValue.count == 1 && newValue != "+" {
                        phoneNumber = "+7(" + phoneNumber
                    } else if newValue.count == 7 {
                        phoneNumber.insert(")", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 6))
                    } else if newValue.count == 10 {
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 10))
                    } else if newValue.count == 13 {
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 13))
                    } else if newValue.count > 16 {
                        phoneNumber.removeLast()
                    }
                })
        }
        .padding()
        .background(Color(hex: "F6F6F9", alpha: 1))
        .cornerRadius(10)
    }
}

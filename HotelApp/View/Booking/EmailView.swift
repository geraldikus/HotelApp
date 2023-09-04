//
//  EmailView.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

struct EmailView: View {
    @Binding var email: String
    @State private var isEmailValid = true
    @State private var errorMessage = ""

    var body: some View {
        
        VStack(alignment: .leading, spacing: 1) {
            Text("Email")
                .font(.caption)
                .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            
            TextField("Email", text: $email, onCommit: {
                validateEmail()
            })
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .onChange(of: email, perform: { newValue in
                isEmailValid = true
                errorMessage = ""
            })
            .overlay(
                Text(errorMessage)
                    .foregroundColor(.red)
                    .opacity(isEmailValid ? 0 : 1)
                    .padding(.bottom, 40)
            )
        }
        .padding()
        .background(Color(hex: "F6F6F9", alpha: 1))
        .cornerRadius(10)
    }
    
     func validateEmail() {
        if !isValidEmail(email) {
            errorMessage = "Email введен неверно"
            isEmailValid = false
        } else {
            isEmailValid = true
            errorMessage = ""
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(ru)?$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

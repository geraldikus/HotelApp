//
//  TouristTextFieldView.swift
//  HotelApp
//
//  Created by Anton on 06.09.23.
//

import SwiftUI

struct TouristTextFieldView: View {
    var name: String
    @Binding var binding: String
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            if isEditing || !binding.isEmpty {
                Text(name)
                    .font(.caption)
                    .foregroundColor(Color(hex: "A9ABB7", alpha: 1))
            }
            
            TextField(name, text: $binding, onEditingChanged: { editing in
                isEditing = editing
            }, onCommit: {
                
            })
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        }
        .padding()
        .background(Color(hex: "F6F6F9", alpha: 1))
        .cornerRadius(10)
    }
}

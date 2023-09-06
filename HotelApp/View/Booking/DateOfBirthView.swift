//
//  DateOfBirthView.swift
//  HotelApp
//
//  Created by Anton on 06.09.23.
//

import SwiftUI

struct DateOfBirthView: View {
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
            
            TextField("Дата рождения", text: $binding)
                .keyboardType(.numberPad)
                .onChange(of: binding, perform: { newValue in
                    if newValue.count == 2 {
                        binding += "."
                    } else if newValue.count == 5 {
                        binding += "."
                    } else if newValue.count > 10 {
                        binding.removeLast()
                    }
                })
        }
        .padding()
        .background(Color(hex: "F6F6F9", alpha: 1))
        .cornerRadius(10)
    }
}

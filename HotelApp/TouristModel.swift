//
//  TouristModel.swift
//  HotelApp
//
//  Created by Anton on 05.09.23.
//

import Foundation

class Tourist: ObservableObject {
    @Published var touristName: String = ""
    @Published var touristLastName: String = ""
    @Published var dateOfBirth: String = ""
    @Published var citizenship: String = ""
    @Published var passportNumber: String = ""
    @Published var passportExpirationDate: String = ""
    
    var isDataEmpty: Bool {
        return touristName.isEmpty || touristLastName.isEmpty || dateOfBirth.isEmpty || citizenship.isEmpty || passportNumber.isEmpty || passportExpirationDate.isEmpty
    }
}


//
//  BookingViewModel.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

class BookingViewModel: ObservableObject {
    @Published var bookingModel: BookingModel?
    
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var touristName: String = ""
    @Published var touristLastName: String = ""
    @Published var dateOfBirth: String = ""
    @Published var citizenship: String = ""
    @Published var passportNumber: String = ""
    @Published var passportExpirationDate: String = ""
    
    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let booking = try JSONDecoder().decode(BookingModel.self, from: data)
                DispatchQueue.main.async {
                    self?.bookingModel = booking
                }
            } catch {
                print("Error in Do/Catch: \(error)")
            }
        }
        task.resume()
    }
}

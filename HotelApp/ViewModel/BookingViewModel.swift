//
//  BookingViewModel.swift
//  HotelApp
//
//  Created by Anton on 04.09.23.
//

import SwiftUI

class BookingViewModel: ObservableObject {
    @Published var bookingModel: BookingModel?
    
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

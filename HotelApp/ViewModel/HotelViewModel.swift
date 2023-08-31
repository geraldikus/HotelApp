//
//  HotelViewModel.swift
//  HotelApp
//
//  Created by Anton on 31.08.23.
//

import SwiftUI

class HotelViewModel: ObservableObject {
    
    @Published var hotelModel: Hotel?
    @Published var loadedImages: [(url: String, image: UIImage)] = []
    
    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let hotel = try JSONDecoder().decode(Hotel.self, from: data)
                DispatchQueue.main.async {
                    self?.hotelModel = hotel
                    self?.loadImages(from: hotel.image_urls)
                }
            } catch {
                print("Error in Do/Catch: \(error)")
            }
        }
        task.resume()
    }
    
    private func loadImages(from urls: [String]) {
        DispatchQueue.global().async {
            var images: [(url: String, image: UIImage)] = []
            for url in urls {
                if let imageUrl = URL(string: url), let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    images.append((url: url, image: image))
                }
            }
            DispatchQueue.main.async {
                self.loadedImages = images
            }
        }
    }
}

//
//  RoomViewModel.swift
//  HotelApp
//
//  Created by Anton on 01.09.23.
//

import SwiftUI

class RoomViewModel: ObservableObject {
    @Published var roomListModel: RoomListModel?
    @Published var loadedImages: [(url: String, image: UIImage)] = []
    @Published var roomModel: RoomModel?
    
    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd") else {
            print("Something wrong with API")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let roomList = try JSONDecoder().decode(RoomListModel.self, from: data)
                DispatchQueue.main.async {
                    self?.roomListModel = roomList
                    self?.loadImages(from: roomList.rooms.flatMap { $0.image_urls })
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

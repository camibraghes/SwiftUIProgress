//
//  ImageLoadingViewModel.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellable = Set<AnyCancellable>()
    
    let manager = PhotoModelCacheManager.instance
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloadin image now")
        }
    }
    
    func downloadImage() {
        print("Downloadin image now")
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
        //            .map { (data, response) -> UIImage? in
        //                return UIImage(data: data)
        //            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let image = returnedImage else { return }
                self.image = image
                self.manager.add(key: self.imageKey as NSString, value: image)
            }
            .store(in: &cancellable)
        
    }
}

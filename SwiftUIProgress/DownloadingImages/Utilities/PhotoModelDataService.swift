//
//  PhotoModelDataService.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 11.05.2022.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    
    @Published var photoModel: [PhotoModel] = []
    var cancellable = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case.finished:
                    break
                case.failure(let error):
                    print("Error downloading data.\(error)")
                }
            } receiveValue: { [weak self] (returnedPhotoModels) in
                self?.photoModel = returnedPhotoModels
            }
            .store(in: &cancellable)

    }

    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws ->Data {
        guard
            let reponse = output.response as? HTTPURLResponse,
            reponse.statusCode >= 200 && reponse.statusCode <= 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

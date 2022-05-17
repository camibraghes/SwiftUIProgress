//
//  DownloadingImagesViewModel.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 11.05.2022.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModel
            .sink { [weak self] (returnedPhotoModel) in
                self?.dataArray = returnedPhotoModel
            }
            .store(in: &cancellable)
    }
}

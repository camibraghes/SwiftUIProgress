//
//  DownloadingImages.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 11.05.2022.
//

import SwiftUI

// Codable
// Background threads
// Weak Self
// Combine
// Publishers and Subscribers
// File Manager
// NSCache

struct DownloadingImages: View {
    
    @StateObject var viewModel = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

struct DownloadingImages_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImages()
    }
}

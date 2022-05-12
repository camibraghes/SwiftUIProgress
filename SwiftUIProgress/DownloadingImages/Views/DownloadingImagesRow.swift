//
//  DownloadingImagesRow.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 12.05.2022.
//

import SwiftUI

struct DownloadingImagesRow: View {
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(model: PhotoModel(albumId: 23, id: 1, title: "The Beatles", url: "htpps:beatlesunknown.dhfyd", thumbnailUrl: "https://via.thebeatles.com/150/92c952"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

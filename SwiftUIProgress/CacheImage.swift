//
//  CacheImage.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 10.05.2022.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
        }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheImageCacheImageViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "steve"
    let manager = CacheManager.instance

    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else {return}
        infoMessage =  manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache!"
        } else {
            infoMessage = "Image not found in Cache!"
            cachedImage = nil
        }
    }
}

struct CacheImage: View {
    
    @StateObject var viewModel = CacheImageCacheImageViewModel()

    
    var body: some View {
        NavigationView {
            VStack {
                if let image = viewModel.startingImage {
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                            .cornerRadius(10)
                }
                Text(viewModel.infoMessage)
                    .font(.headline)
                    .foregroundColor(Color.green)
                
                HStack {
                    Button { viewModel.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 50)
                            .background(.blue)
                            .cornerRadius(10)
                    }

                    Button { viewModel.removeFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(width: 180, height: 50)
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                Button { viewModel.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(width: 180, height: 50)
                        .background(.gray)
                        .cornerRadius(10)
                }
                
                if let image = viewModel.cachedImage {
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                            .cornerRadius(10)
                }
                Spacer()

            }
        }
        .navigationTitle("Cache")
    }
}


struct CacheImage_Previews: PreviewProvider {
    static var previews: some View {
        CacheImage()
    }
}

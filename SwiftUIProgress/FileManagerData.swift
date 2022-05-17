//
//  FileManager.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 09.05.2022.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    let folderName = "MyApp_Images"
    
    init() {
        createdFolderIfNeeded()
    }
    
    func createdFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                print("Success creating folder.".uppercased())
            } catch let error {
                print("Error creating folder.\(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder.\(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return"Error getting data."
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving."
        } catch let error {
            return "Error saving\(error)"
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        return UIImage(contentsOfFile: path)
        
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting path."
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted."
        } catch let error {
            return "Error deleting image.\(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("MyApp_Images")
                .appendingPathComponent("\(name).jpg") else {
            print("Errors getting data.")
            return nil
        }
        return path
    }
}

class FileManagerDataViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "steve"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetsFolder()
        saveImage()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else {return}
        infoMessage = manager.saveImage(image: image , name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerData: View {
    
    @StateObject var viewModel = FileManagerDataViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button { viewModel.saveImage()
                    } label: {
                        Text("Save to File Manager")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button { viewModel.deleteImage()
                    } label: {
                        Text("Delete")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(width: 150, height: 50)
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                Text(viewModel.infoMessage)
                    .font(.callout)
                    .foregroundColor(Color.blue)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerData_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerData()
    }
}

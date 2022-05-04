//
//  DownloadWithEscaping.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 02.05.2022.
//

import SwiftUI

//struct PostModel: Identifiable, Codable {
//    let userId: Int
//    let id = Int
//    let title: String
//    let body: String
// 
//}
class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { returnetData in
            if let data = returnetData {
                
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned")
        }
    }
}
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ())  {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode <= 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
        
            completionHandler(data)
        }.resume()
    }
}

struct DownloadWithEscaping: View {
    
    @StateObject var viewModel = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                        .foregroundColor(.pink)
                    Text(post.body)
                        .font(.caption)
                }
                .padding()
            }
        }
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}

//
//  DownloadWithCombine.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 04.05.2022.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellable = Set<AnyCancellable>()
    
    init() {}
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //Combine Discussion
        /*
         //1. Sign up for the monthly subscription for package to be delivered
         //2. The company would make the package behind the scene
         //3. Recieve the package at your front door
         //4. Make sure the box isn't demaged
         //5. Open and make sure the item is correct
         //6. Use the item!!
         //7. Cancellable at any time!
         
         //1. Create the publisher
         //2. subscribe pub;isher on background thread (don't actually need this line because this data test publisher is alredy on backgroung thread)
         //3. recieve on main thread
         //4. tryMap (check that the data is good)
         //5. decode (decode data into PostModels)
         //6. sink (put the item in our app)
         //7. store (cancel subscription id nedded)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
            .store(in: &cancellable)
        
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var viewModel = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { posts in
                VStack(alignment: .leading){
                    Text(posts.title)
                        .font(.headline)
                    Text(posts.body)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}

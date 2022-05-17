//
//  Arrays.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 13.04.2022.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //    MARK: First Method - Sort
        /*        filteredArray = dataArray.sorted(by: { user1, user2 in
         return user1.point > user2.point
         })
         filteredArray = dataArray.sorted(by: { $0.point < $1.point })
         */
        
        //    MARK: Second Method - Filtrer
        /*         filteredArray = dataArray.filter({ (user) -> Bool in
         return !user.isVerified
         })
         filteredArray = dataArray.filter({ $0.isVerified})
         */
        
        //    MARK: Third Method - Map
        /*        mappedArray = dataArray.map({ (user) -> String in
         return user.name ?? "Unknown"
         })
         mappedArray = dataArray.map({$0.name})
         mappedArray = dataArray.compactMap({ (user) -> String? in
         return user.name
         })
         mappedArray = dataArray.compactMap({$0.name})
         */
        
        mappedArray = dataArray
            .sorted(by: { $0.point > $1.point})
            .filter({ $0.isVerified })
            .compactMap({ $0.name})
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nich", point: 50, isVerified: true)
        let user2 = UserModel(name: "Joe", point: 63, isVerified: false)
        let user3 = UserModel(name: "Chris", point: 89, isVerified: false)
        let user4 = UserModel(name: nil, point: 37, isVerified: true)
        let user5 = UserModel(name: "Jason", point: 69, isVerified: false)
        let user6 = UserModel(name: "IOn", point: 44, isVerified: false)
        let user7 = UserModel(name: "Jhoana", point: 25, isVerified: true)
        let user8 = UserModel(name: "Marie", point: 71, isVerified: true)
        let user9 = UserModel(name: "Ann", point: 38, isVerified: true)
        let user10 = UserModel(name: "Samantha", point: 100, isVerified: true)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
}

struct Arrays: View {
    
    @StateObject var viewModel = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(viewModel.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.brown)
                        .background(Color.black.cornerRadius(10))
                }
                
                // Foreach for dataArray var
                /*                ForEach(viewModel.filteredArray) { user in
                 VStack(alignment: .leading){
                 Text(user.name)
                 .font(.headline)
                 .foregroundColor(.brown)
                 HStack() {
                 Text("Points: \(user.point)")
                 Spacer()
                 if user.isVerified {
                 Image(systemName: "flame.fill")
                 .foregroundColor(.brown)
                 }
                 }
                 .foregroundColor(.brown)
                 }
                 .padding()
                 .background(Color.primary.cornerRadius(8))
                 }
                 */
            }
        }
    }
}

struct Arrays_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Arrays()
                .preferredColorScheme(.light)
            
        }
    }
}

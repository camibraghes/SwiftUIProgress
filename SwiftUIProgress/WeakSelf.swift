//
//  WeakSelf.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 27.04.2022.
//

import SwiftUI

struct WeakSelf: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
            .navigationTitle("First View")
        }
        .overlay(textOverlay, alignment: .topTrailing)
    }
    
    var textOverlay: some View {
        Text("\(count ?? 0)")
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .background(Color.green .cornerRadius(10))
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var viewModel = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack{
            Text("Second View")
                .font(.title)
                .bold()
                .foregroundColor(.pink)
            if let data = viewModel.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 50, execute: { [ weak self] in
            self?.data = "NEW DATA!!"
        })
    }
}

struct WeakSelf_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelf()
    }
}

//
//  HashableView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 13.04.2022.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableView: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(data, id: \.self ) { item in
                    Text(item.title)
                        .font(.headline)
                        .foregroundColor(.pink)
                }
            }
        }
    }
}

struct HashableView_Previews: PreviewProvider {
    static var previews: some View {
        HashableView()
    }
}

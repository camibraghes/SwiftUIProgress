//
//  MultipleSheetsView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 30.03.2022.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let name: String
}

struct MultipleSheetsView: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(name: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextSheet(selectedModel: model)
            }
        }
    }
}


struct NextSheet: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.name)
            .font(.largeTitle)
        
    }
}

struct MultipleSheetsView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsView()
    }
}

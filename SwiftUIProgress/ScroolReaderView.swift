//
//  ScroolReaderView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 29.03.2022.
//

import SwiftUI

struct ScroolReaderView: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 50)
                .font(.headline)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            .frame(width: 180, height: 40)
            .foregroundColor(.red)
            .font(.headline)
            .background(Color.gray)
            .cornerRadius(10)
            
            ScrollView {
                ScrollViewReader { proxi in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()) {
                            proxi.scrollTo(value, anchor: nil)
                        }
                    }
                }
            }
        }
    }
}

struct ScroolReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScroolReaderView()
    }
}

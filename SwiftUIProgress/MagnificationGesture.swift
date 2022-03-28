//
//  MagnificationGesture.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 28.03.2022.
//

import SwiftUI

struct MagnificationGesture1: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("SwiftUIProgress")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value - 1
                    }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption on my photo!")
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
        }
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGesture1()
    }
}


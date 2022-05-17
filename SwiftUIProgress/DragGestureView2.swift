//
//  DragGestureView2.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 29.03.2022.
//

import SwiftUI

struct DragGesrureView2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffset: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffset)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentDragOffset = value.translation.height
                            }
                            
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if currentDragOffset < -150 {
                                    endingOffsetY = -startingOffsetY
                                    MySignUpView().isChevronUp = false
                                    
                                    
                                } else if endingOffsetY != 0 && currentDragOffset > 150 {
                                    endingOffsetY = 0
                                    MySignUpView().isChevronUp = true
                                }
                                currentDragOffset = 0
                            }
                        }
                    
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGesrureView2_Previews: PreviewProvider {
    static var previews: some View {
        DragGesrureView2()
    }
}

struct MySignUpView: View {
    
    @State var isChevronUp: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: isChevronUp ? "chevron.down" : "chevron.up")
                .padding(.top)
                .font(.headline)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        isChevronUp.toggle()
                    }
                }
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Text("This is the description for our app. This is my favorite application and I recomanded to all my friends to instal application.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("CREATE AN ACCOUNT!")
                .foregroundColor(.green)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black)
                .cornerRadius(15)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}

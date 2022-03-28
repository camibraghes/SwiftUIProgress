//
//  LongPressGesture.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 28.03.2022.
//

import SwiftUI

struct LongPressGesture: View {
    
    @State var isComplete: Bool = false  
    @State var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.gray))
            
            HStack {
             Text("Click here")
                .padding()
                .font(.headline)
                .background(Color(.black))
                .foregroundColor(.white)
                .cornerRadius(10)
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                    if isPressing {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isComplete = true
                        }
                    } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        isComplete = false
                                }
                            }
                        }
                    }
                    
                } perform: {
                    withAnimation(.easeInOut) {
                        isSuccess = true
                    }
                }

            
             Text("Reset")
               .padding()
               .font(.headline)
               .background(Color(.black))
               .foregroundColor(.white)
               .cornerRadius(10)
               .onTapGesture {
                   isComplete = false
                   isSuccess = false
               }
            }
        }
        
       
//        Text(isComplete ? "Completed" : "Not Complete")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 1.0) {
//                isComplete.toggle()
//            }
    }
}

struct LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture()
    }
}

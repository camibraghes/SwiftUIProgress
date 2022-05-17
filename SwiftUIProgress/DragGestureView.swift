//
//  DragGestureView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 28.03.2022.
//

import SwiftUI

struct DragGestureView: View {
    
    @State var offSet: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(offSet.width)")
                Spacer()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offSet)
                .scaleEffect(getScaleEffect())
                .rotationEffect(Angle(degrees: getRotationEffect()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                offSet = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offSet = .zero
                            }
                        }
                )
        }
    }
    
    func getScaleEffect() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offSet.width)
        let percentage = currentAmount/max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationEffect() -> Double  {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offSet.width
        let percentange = currentAmount/max
        let percentageAsDouble = Double(percentange)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}

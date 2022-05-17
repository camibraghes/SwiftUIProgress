//
//  GeometryReaderView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 30.03.2022.
//

import SwiftUI

struct GeometryReaderView: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistace = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1-(currentX / maxDistace))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(
                                    degrees: getPercentage(geo: geometry) * 20
                                ),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
            .previewInterfaceOrientation(.portrait)
    }
}

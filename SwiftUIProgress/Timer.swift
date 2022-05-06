//
//  Timer.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 05.05.2022.
//

import SwiftUI

struct Timer: View {
    
    let timer = Timer.pu
    
    @State var currentVar: Date = Date()

    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.purple, Color.black]),
                center: .center,
                startRadius: 10, endRadius: 500)
                .ignoresSafeArea()
            
            Text(currentVar.description)
                .font(.system(size: 70, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { value in
            currentVar = value
        }
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        Timer()
    }
}

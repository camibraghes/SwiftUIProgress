//
//  Timers.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 05.05.2022.
//

import SwiftUI

struct Timers: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    //Current Time
    /*
     @State var currentDate: Date = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     return formatter
     }
     */
    
    //Coundown
    /*
     @State var count = 10
     @State var finishedText: String? = nil
     */
    
    //Countdown to Date
    /*
     @State var timeRemaining: String = ""
     let futureData: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining() {
     let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureData)
     let hour = remaining.hour ?? 0
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     timeRemaining = "\(hour): \(minute): \(second)"
     }
     */
    
    //Animation Counter
    
    @State var count = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.purple, Color.black]),
                center: .center,
                startRadius: 10,
                endRadius: 500)
            .ignoresSafeArea()
            
            /*
             HStack(spacing: 10) {
             Circle()
             .offset(y: count == 1 ? -20 : 0)
             Circle()
             .offset(y: count == 2 ? -20 : 0)
             Circle()
             .offset(y: count == 3 ? -20 : 0)
             }
             .foregroundColor(.white)
             .frame(width: 120)
             }
             .onReceive(timer) {_ in
             withAnimation(.easeInOut(duration: 0.5)) {
             count = count == 3 ? 0 : count + 1
             }
             //            OR:
             //            if count == 3 {
             //                count = 0
             //            } else {
             //                count += 1
             //            }
             */
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.gray)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.black)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            .onReceive(timer) {_ in
                withAnimation(.default) {
                    count = count == 5 ? 0 : count + 1
                }
            }
        }
    }
}

struct Timers_Previews: PreviewProvider {
    static var previews: some View {
        Timers()
    }
}

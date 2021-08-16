//
//  TestWorkoutStartTimer.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 04/02/21.
//

import Foundation
import SwiftUI

struct TestWorkoutStartTimer : View {
    
    let timer = Timer.publish(every: 1.2, on: .main, in: .common).autoconnect()
    @State private var counter = 3
    @State private var isactiveee = false
    let screenHeight = WKInterfaceDevice.current().screenBounds.size.height
    let screenWidth = WKInterfaceDevice.current().screenBounds.size.width
    @State private var progressValue = 100.0
    
    var body: some View{
        NavigationView {
            
            HStack() {
                ZStack {
                    PercentageRing(
                        ringWidth: 8, percent: progressValue ,
                        backgroundColor: ColorManager.darker.opacity(0.4),
                        foregroundColors: [Color(#colorLiteral(red: 0.4757325649, green: 0.8559685349, blue: 1, alpha: 1)) ,Color(#colorLiteral(red: 0.5607843137, green: 0.8862745098, blue: 0.9058823529, alpha: 1))]
                    )
                    .animation(.easeInOut(duration: 0.5))
                    
                    Text("\(self.counter)")
                        .frame(width: 100, height: 100)
                        //                    .animation(.easeInOut(duration: 0.3))
                        .font(.system(size: 65, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(ColorManager.lightBlue)
                        .onReceive(timer) { time in
                            
                            if self.counter == 0 {
                                self.timer.upstream.connect().cancel()
                                self.isactiveee = true
                                progressValue =  0.0
                                WKInterfaceDevice.current().play(.success)
                                
                            } else {
                                self.counter -= 1
                                progressValue =  33.33 * Double(counter)
                                WKInterfaceDevice.current().play(.start)
                            }
                        }
                }.frame(width: screenWidth).padding(.leading, 5)
                Spacer()
                
            }.frame(width: (screenWidth), height: 80, alignment: .center)
            
            //start button
            NavigationLink(destination: PagerBaseView(), isActive : $isactiveee ) {
            }
            .buttonStyle(PlainButtonStyle())
        }.navigationBarHidden(true)
    }
    
}

struct TestWorkoutStartTimer_Previews: PreviewProvider {
    
    static var previews: some View {
        TestWorkoutStartTimer()
    }
}

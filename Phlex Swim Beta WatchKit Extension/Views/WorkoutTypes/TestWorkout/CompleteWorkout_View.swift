//
//  CompleteWorkout_View.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 20/02/21.
//

import Foundation
import SwiftUI

struct CompleteWorkout_View : View{
    
    @State var IsCompleteScreen: Bool = false
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    var body: some View{
        
        VStack{
            Image("check")
                .frame(width: 80, height: 80, alignment: .center)
            Text("Great job").font(.system(size: 12)).foregroundColor(.gray)
            
            Text("Workout \n Completed")
                .font(.system(size: 25, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(ColorManager.lightBlue)
                .lineLimit(3)
                .frame(width: 130, height: 60, alignment: .center)
                .onReceive(timer) { time in
                    IsCompleteScreen = true
                }
            
            //start button
            NavigationLink(destination: ProfileStatsView(), isActive : $IsCompleteScreen ) {
            }
            .buttonStyle(PlainButtonStyle())
            
        }
    }
}

struct CompleteWorkout_View_Previews: PreviewProvider {
    static var previews: some View {
        CompleteWorkout_View()
    }
}

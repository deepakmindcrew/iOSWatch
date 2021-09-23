//
//  OpenWaterExplainer.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI
import Combine
import HealthKit
import Foundation

struct OpenWaterExplainer: View {
    @State var workoutInProgress = false
    let startAction: (() -> Void)? // The start action callback.
    
    var body: some View{
        VStack{
            VStack(alignment: .center){
                Text("Open Water")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.lightBlue)
                
                
                
                Text("This is an Open Water Workout. Havent implemented GPS yet.")
                    .fixedSize(horizontal: false, vertical: true).font(.system(size: 12, weight: .medium))
                    .foregroundColor(ColorManager.iron)
                
            }
            SwimButton(action: {
                self.startAction!() // FixMe!
            })
        }.padding(.top, 50).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(""))
    }
}

struct OpenWaterExplainer_Previews: PreviewProvider {
    static var startAction = { }
    
    static var previews: some View {
        OpenWaterExplainer(startAction: startAction)
    }
}

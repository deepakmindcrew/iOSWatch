//
//  GuidedWorkoutExplainer.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI

struct GuidedWorkoutExplainer: View {
    @State var workoutInProgress = false
    let startAction: (() -> Void)? // The start action callback.
    
    var body: some View{
        VStack{
            VStack(alignment: .center){
                Text("Guided Workout")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.lightBlue)
                
                Text("This is a Guided Workout. This is for programmatic workouts")
                    .fixedSize(horizontal: false, vertical: true).font(.system(size: 12, weight: .medium))
                    .foregroundColor(ColorManager.iron)
                
            }
            SwimButton(action: {
                self.startAction!() // FixMe!
            })
        }.padding(.top, 50).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(""))
    }
}

struct GuidedWorkoutExplainer_Previews: PreviewProvider {
    static var startAction = { }
    
    static var previews: some View {
        GuidedWorkoutExplainer(startAction: startAction)
    }
}

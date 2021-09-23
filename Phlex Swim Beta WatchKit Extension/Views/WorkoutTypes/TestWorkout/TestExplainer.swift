//
//  TestExplainer.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI
import Foundation
import WatchKit

struct TestExplainer: View {
    @State var workoutInProgress = false
    let startAction: (() -> Void)? // The start action callback.
    
    var body: some View{
        VStack{
            VStack(alignment: .center){
                Text("Test Workout")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.lightBlue)
                
                Text("This is a test workout \n rigged to record a walk.")
                    .fixedSize(horizontal: false, vertical: true).font(.system(size: 12, weight: .medium))
                    .foregroundColor(ColorManager.iron)
            }
            SwimButton(action: {
                self.startAction!() // FixMe!
            })
        }.padding(.top, 50).navigationBarTitle(Text(""))
    }
}



// Custom button style of the run button.
struct SwimStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(ColorManager.darkblue)
            .overlay(
                configuration.label
                    .foregroundColor(.white)
                    .font(Font.system(size: 28, weight: .black, design: .default))
            )
            .frame(width: 100, height: 100)
    }
}

struct SwimButton: View {
    var action = { print("Run button tapped!") }
    
    var body: some View {
        Button(action: { self.action() }) {
            Text("SWIM")
        }
        .buttonStyle(SwimStyle())
    }
}


struct TestExplainer_Previews: PreviewProvider {
    static var startAction = { }
    static var previews: some View {
        TestExplainer(startAction: startAction)
    }
}

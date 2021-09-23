//
//  FreeSwimExplainer.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI

struct FreeSwimExplainer: View {
    var body: some View {
        VStack{        Text("Pick one for the pool length")
            
            Button(
                action: {
                    // did tap
                    
    print("Starting short course yards workout")
                },
                label: { Text("SCY") }
            )
            Button(
                action: {
                    // did tap
            
    print("Starting Short Course meters workout")
                },
                label: { Text("SCM") }
                )
            Button(
                action: {
                    // did tap
            print("Starting Long Course workout")
                },
                label: { Text("LCM") }
            )
            }
        }
    }


struct FreeSwimExplainer_Previews: PreviewProvider {
    static var previews: some View {
        FreeSwimExplainer()
    }
}

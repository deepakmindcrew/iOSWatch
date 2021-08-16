//
//  DetailView.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI

struct DetailView: View {
    let startType: String
    let focus: String
    let distance: Double
    let unit: String
    @EnvironmentObject var workoutSession: WorkoutManager
    @Environment(\.presentationMode) private var presentation

    let startAction: (() -> Void)? // The start action callback.
    
    @ViewBuilder
    var body: some View {
        VStack{
            Text(startType)
                .font(.system(size: 25, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(ColorManager.lightBlue)
            
            HStack {
                Text("Focus:")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(ColorManager.iron)
                
                
                Text(focus)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(ColorManager.iron)
            }
            
            
            HStack {
                Text("Length:")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(ColorManager.iron)
                
                
                Text("\(distance, specifier: "%.f")\(unit)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(ColorManager.iron)
            }
            Text("Go to start \(startType)")
            SwimButton(action: {
                self.startAction!() // FixMe!
            })
        }.onTapGesture {
            self.startAction!()
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


    }

struct StartButton: View {
    var body: some View {
        Button(action: {
                       print("Share tapped!")
                   }) {
                       HStack {
                           Text("Swim Now")
                               .fontWeight(.semibold)
                               .font(.subheadline)
                            
                       }
                       .foregroundColor(.white)
                       .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                       .cornerRadius(10)
                       
        }
    }
}
    
    



struct DetailView_Previews: PreviewProvider {
    static var startAction = { }

    
    static var previews: some View {
        DetailView(startType: "Open Water", focus: "turns", distance: 2500, unit: "M", startAction: startAction)
    }
}

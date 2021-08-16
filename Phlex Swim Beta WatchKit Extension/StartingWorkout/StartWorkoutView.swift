//
//  StartWorkoutView.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//
// This view allows the user to review the workout they are about to do, then start it

import SwiftUI
import Combine
import Foundation
import HealthKit
import WatchKit

struct workouts: Identifiable {
    var id = UUID()
    var Distance: String
    var focus: String
    var workoutName: String
}
struct StartWorkoutView: View {
    
    @EnvironmentObject var workoutSession: WorkoutManager
    
    let startAction: (() -> Void)? // The start action callback.
    
    var body: some View {
        VStack{
        
            WorkoutDetailsOverview()
//        WarmUpView()
//
//        MainSet()
//
//        WarmDown()

        SwimButton(action: {
            self.startAction!() // FixMe!
        }).onAppear() {
            // Request HealthKit store authorization.
            self.workoutSession.requestAuthorization()
        }
        }.padding(.top, 30).edgesIgnoringSafeArea(.all).navigationBarHidden(true)
    }
    


struct InitialView_Previews: PreviewProvider {
    static var startAction = { }
    
    static var previews: some View {
        StartWorkoutView(startAction: startAction)
            .environmentObject(WorkoutManager())
            .environmentObject(MotionManager())    }
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



struct workoutRow: View {
    var workout: workouts
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(workout.workoutName)")
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(ColorManager.lightBlue)
            
            Text("Distance: \(workout.Distance)m")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
            
            
            Text("Focus: \(workout.focus)")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
        }.padding(5)
    }
}

struct workoutContent: View {
    var body: some View {
        let first = workouts(Distance: "4500", focus: "Backstroke Kick", workoutName: "Test Set")
        
        let second = workouts(Distance: "4500", focus: "Cardio", workoutName: "Test Set")
        
        let third = workouts(Distance: "4500", focus: "Weight Loss", workoutName: "Test Set")
        
        let fourth = workouts(Distance: "4500", focus: "Test Set", workoutName: "Test Set")
        
        let workouts = [first, second, third, fourth]
        
        return List(workouts, rowContent: workoutRow.init)
        
    }
}

struct TitleFocusLength: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Lung Buster")
                .font(.system(size: 25, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(ColorManager.lightBlue)
            
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Focus:")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(ColorManager.iron)
                    
                    
                    Text("Work Your Walls")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(ColorManager.iron)
                        .offset(x: -5)
                }
                
                
                HStack {
                    Text("Length:")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(ColorManager.iron)
                    
                    
                    Text("3,500 yd")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(ColorManager.iron)
                        .offset(x: -5)
                }
                
            }
            
            
        }
    }
}

struct WarmUpView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 30)
                        .foregroundColor(.green)
                    
                    Text("25")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading) {
                    Text("Warm Up")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5)
                    
                    Text("9 x 200 FR 2 min 12 x 100 EZ 3 min")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5)
                    
                }
            }
        }
    }
}

struct WorkoutDetailsOverview: View {
    var body: some View {
        VStack(alignment: .leading){
            TitleFocusLength()
            
            HStack {
                Text("Difficulty:")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(ColorManager.iron)
                Text("Moderate")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.yellow)
                    .offset(x: -5)
            }
        }
    }
}

struct MainSet: View {
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 30)
                        .foregroundColor(.red)
                    
                    Text("25")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading) {
                    Text("Main Set")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5)
                    
                    Text("12 x 400IM on 5 min")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5)
                    
                    
                    
                    
                    
                }.padding(5)
            }
        }
        
    }
}


struct WarmDown: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 30)
                        .foregroundColor(.orange)
                    
                    Text("25")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading) {
                    Text("Warm Down")
                        .font(.system(size: 14, weight: .regular))
                        .padding(.top, 5)
                    
                    Text("10 x 100 IMO")
                        .font(.system(size: 14, weight: .regular))
                        .padding(.top, 5)
                    
                    
                    
                    
                    
                }.padding(5)
            }
        }
        
    }
}

}

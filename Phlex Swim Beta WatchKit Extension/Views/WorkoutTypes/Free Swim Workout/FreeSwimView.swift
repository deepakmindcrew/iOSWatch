//
//  FreeSwimView.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/19/20.
//

import SwiftUI
import Combine
import CoreMotion
import Foundation

struct FreeSwimWkt: View {
    @EnvironmentObject var workoutSession: WorkoutManager
    let pauseAction: (() -> Void) // Callback to toggle pausing / resuming a workout.
    let endAction: (() -> Void) // Callback to end a workout.
    @State var workoutPaused: Bool = false // Internal workout state.

    var body: some View {
        VStack {
            ScrollView {
                
               VStack {
                    Text("Free Swim")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(ColorManager.lightBlue)
                
                Text("\(workoutSession.heartrate, specifier: "%.f") ❤️")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                
                    Text("\(elapsedTimeStringer(elapsed: secondsToHoursMinutesSecondss(seconds: workoutSession.elapsedSeconds))) ⏰")
                        .font(.system(size: 24, weight: .medium, design: .rounded))

                }
            VStack(alignment: .center) {
                
                    Text("Distance \(workoutSession.distance, specifier: "%.f")")
                
                    Text("Strokes \(workoutSession.swimstroke, specifier: "%.f")")
                
                    Text("Calories \(workoutSession.activeCalories, specifier: "%.f")")
            }
                // The button that end a workout.
                MenuButton(title: "End", symbolName: "stop.circle.fill", action: {
                    print("End tapped!")
                    self.endAction()
                    self.workoutPaused = false
                }).foregroundColor(.red)        }
    }
    }
    
    // Convert the seconds into seconds, minutes, hours.
    func secondsToHoursMinutesSecondss (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // Convert the seconds, minutes, hours into a string.
    func elapsedTimeStringer(elapsed: (h: Int, m: Int, s: Int)) -> String {
        return String(format: "%d:%02d:%02d", elapsed.h, elapsed.m, elapsed.s)
    }
}


struct FreeSwimWkt_Previews: PreviewProvider {
    static var pauseAction = { }
    static var endAction = { }
    static var previews: some View {
        FreeSwimWkt(pauseAction: pauseAction, endAction: endAction)
            .environmentObject(WorkoutManager())

    }
}

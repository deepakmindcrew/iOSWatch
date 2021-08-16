//
//  SCYFreeSwimWkt.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/21/20.
//

import SwiftUI
import Combine
import CoreMotion
import Foundation

struct SCYFreeSwimWkt: View {
    @EnvironmentObject var workoutSession: WorkoutManager
let pauseAction: (() -> Void) // Callback to toggle pausing / resuming a workout.
let endAction: (() -> Void) // Callback to end a workout.
@State var workoutPaused: Bool = false // Internal workout state.
    
    var body: some View {
            ScrollView {
               VStack {
                        Text("25YD Free Swim")
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
                }    // The button that end a workout.
                HStack {
                    MenuButton(title: "End", symbolName: "stop.circle.fill", action: {
                        print("End tapped!")
                        self.endAction()
                        self.workoutPaused = false
                    }).foregroundColor(.red).padding()
                    MenuButton(title: "Lock", symbolName: "lock.circle.fill", action: {
    //                    GuidedView()
                        print("Water Lock Enabled!")
                        if #available(watchOSApplicationExtension 6.1, *) {
                            WKInterfaceDevice.current().enableWaterLock()
                        } else {
                            // Fallback on earlier versions
                        }
                            
                        }).foregroundColor(.blue).padding()
                
                }.onAppear {
                    workoutSession.checkAuthorization()
                    workoutSession.startWorkout()
                }         }
        
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



struct SCYFreeSwimWkt_Previews: PreviewProvider {
    static var pauseAction = { }
    static var endAction = { }
    static var previews: some View {
        SCYFreeSwimWkt(pauseAction: pauseAction, endAction: endAction)
            .environmentObject(WorkoutManager())
    }
}

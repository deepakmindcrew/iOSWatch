//
//  Open Water View.swift
//  Phlex Swim Beta
//
//  Created by Ryan Rosenbaum on 7/16/20.
//

import SwiftUI
import Combine
import CoreMotion
import Foundation

struct Open_Water_View: View {
    @EnvironmentObject var workoutSession: WorkoutManager
    let queue = OperationQueue()
    @EnvironmentObject var motionManager: MotionManager
    let currentFrequency = 60
    let pauseAction: (() -> Void) // Callback to toggle pausing / resuming a workout.
    let endAction: (() -> Void) // Callback to end a workout.
    @State var workoutPaused: Bool = false // Internal workout state.
    var body: some View {
        ScrollView {
            
           VStack {
                Text("Open Water")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(ColorManager.lightBlue)
            
                Text("\(elapsedTimeString(elapsed: secondsToHoursMinutesSeconds(seconds: workoutSession.elapsedSeconds)))")
                    .font(.system(size: 24, weight: .medium, design: .rounded))

            }
            VStack {
              
                    VStack {
                        HStack {
                            Text("\(workoutSession.distance, specifier: "%.f")")
                            .font(Font.system(size: 26, weight: .medium, design: .rounded).monospacedDigit())
                            .frame(alignment: .leading)
                            .lineLimit(1)
                            Text("km").offset(y: 5)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Text("\(workoutSession.swimstroke, specifier: "%.f") 🏊‍♂️")
                            .font(Font.system(size: 26, weight: .medium, design: .rounded).monospacedDigit())
                                                    
                        }.padding(.all, 10)
                        
                        HStack {
                        Text("\(workoutSession.activeCalories, specifier: "%.f")")
                            .font(Font.system(size: 26, weight: .medium, design: .rounded).monospacedDigit())
                            .frame(alignment: .leading)
                            .lineLimit(1)
                            Text("cal").offset(y: 5)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Text("\(workoutSession.heartrate, specifier: "%.f")")
                            .font(Font.system(size: 26, weight: .medium, design: .rounded).monospacedDigit())
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .animation(.interactiveSpring())
                        }.padding(.all, 10)
                    }
                }
            
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
        }
    }
    }
    
    // Convert the seconds into seconds, minutes, hours.
    func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // Convert the seconds, minutes, hours into a string.
    func elapsedTimeString(elapsed: (h: Int, m: Int, s: Int)) -> String {
        return String(format: "%d:%02d:%02d", elapsed.h, elapsed.m, elapsed.s)
    }
}

struct Open_Water_View_Previews: PreviewProvider {
    static var pauseAction = { }
    static var endAction = { }
    static var previews: some View {
        Open_Water_View(pauseAction: pauseAction, endAction: endAction)
            .environmentObject(WorkoutManager())
            .environmentObject(MotionManager())
    }
}



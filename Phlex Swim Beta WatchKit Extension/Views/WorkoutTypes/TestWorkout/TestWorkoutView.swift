//
//  TestWorkoutView.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI
import Combine
import Foundation

struct TestWorkoutView: View {
    @State var workoutPaused: Bool = false // Internal workout state.
    let pauseAction: (() -> Void) // Callback to toggle pausing / resuming a workout.
    let endAction: (() -> Void) // Callback to end a workout.
    @EnvironmentObject var workoutSession: WorkoutManager
    var body: some View {
        ScrollView {
            VStack{
                Text("\(workoutSession.steps, specifier: "%.f") 🚶‍♀️")
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                Text("\(workoutSession.distanceWalking, specifier: "%.f") Distance")
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .padding(.all, 10)
                Text("\(workoutSession.heartrate, specifier: "%.f") ❤️")
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .padding(.all, 10)
                HStack {
                    Text("\(elapsedTimeStringer(elapsed: secondsToHoursMinutesSecondss(seconds: workoutSession.elapsedSeconds)))")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                    Text(" ⏰")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .frame(height: 50, alignment: .center)
                }.fixedSize(horizontal: false, vertical: true)
            }
            // The button that end a workout.
            MenuButton(title: "End", symbolName: "stop.circle.fill", action: {
                print("End tapped!")
                self.endAction()
                self.workoutPaused = false
            })
            .foregroundColor(.red).padding(.trailing, 6)
            
        }.navigationBarTitle(Text(""))
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


struct TestWorkoutView_Previews: PreviewProvider {
    static var pauseAction = { }
    static var endAction = { }
    

    static var previews: some View {
        TestWorkoutView(pauseAction: pauseAction, endAction: endAction).environmentObject(WorkoutManager())
    }
}

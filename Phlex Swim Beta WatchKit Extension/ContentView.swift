//
//  ContentView.swift
//  Phlex Swim Beta
//
//  Created by Ryan Rosenbaum on 1/23/21.
//

import SwiftUI


struct ContentView: View {
    // Get the business logic from the environment.
//    var workoutSession: WorkoutManager
//    @EnvironmentObject var workoutSession1: WorkoutManager

    // This view will show an overlay when we don't have a workout in progress.
//    @State var workoutInProgress = false
    
    // We need the screen height to know how far to offset the RUN button when the workout is in progress.
//    let screenHeight = WKInterfaceDevice.current().screenBounds.size.height
    @State private var seconds: TimeInterval = 60 * 60 * 12

    static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()

    var body: some View {
        Base_home_view()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("hello")
    }
}

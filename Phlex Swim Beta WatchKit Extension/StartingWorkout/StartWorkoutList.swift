//
//  StartWorkoutList.swift
//  Phlex Swim Beta
//
//  Created by Ryan Rosenbaum on 7/19/20.
//

import SwiftUI
import Combine

struct workoutList: Identifiable {
    let id: Int
    let type: String
    let emoji: String
    let coloring: Color
    let unit: String
    let distance: Double
    let focus: String
}



struct StartWorkoutList: View {
    let startAction: (() -> Void)? // The start action callback.
    @EnvironmentObject var workoutSession: WorkoutManager

    var workoutListItems = [
        workoutList(id: 1, type: "Open Water", emoji: "🏊‍♂️", coloring: .orange, unit: "M", distance: 5000, focus: "Swim straight"),
        
        workoutList(id: 2, type: "Heart Rate", emoji: "🏊‍♂️", coloring: .blue, unit: "M", distance: 5000, focus: "Control HR"),
        
        workoutList(id: 3, type: "Guided Workout", emoji: "🏊‍♂️", coloring: .yellow, unit: "M", distance: 5000, focus: "Follow Along"),
        
        workoutList(id: 4, type: "Free Swim 50M", emoji: "🏊‍♂️", coloring: .red, unit: "M", distance: 5000, focus: "LCM Custom Workout"),
        workoutList(id: 5, type: "Free Swim 25Y", emoji: "🏊‍♂️", coloring: .red, unit: "Y", distance: 5000, focus: "SCY Custom Workout"),
        workoutList(id: 6, type: "Free Swim 25M", emoji: "🏊‍♂️", coloring: .red, unit: "M", distance: 5000, focus: "SCM Custom Workout"),]
    
    var workoutsListing = [workoutList]()
    let pauseAction: (() -> Void) // Callback to toggle pausing / resuming a workout.
    let endAction: (() -> Void) // Callback to end a workout.
    @State var workoutPaused: Bool = false // Internal workout state.
    var body: some View {
        List{
  
            HStack {
                Text("Open Water").foregroundColor(.orange)
                Text("🌊").foregroundColor(.orange)
            }
            Text("Heart Rate").foregroundColor(.blue)
                Text("Guided Workout").foregroundColor(.yellow)
                Text("Free Swim 50M").foregroundColor(.red)
                Text("Free Swim 25yd").foregroundColor(.red)
            NavigationLink(destination:
                            LongFreeSwimPaging().environmentObject(workoutSession)
                            .onAppear {
                                self.startAction!()
                            }
                
            ) {
                Text("Free Swim 25yd")
            }.navigationBarTitle(Text("Master"))
            NavigationLink(destination:
                            HeartRateWkt(pauseAction: pauseAction, endAction: endAction).environmentObject(workoutSession)
                            .onAppear {
                                self.startAction!()
                            }
                
            ) {
                Text("Heart Rate Workout View")
            }.navigationBarTitle(Text("Master"))
        
                Text("Free Swim 25M").foregroundColor(.red)
            
            Button(
                action: {
                    self.startAction!()
                    // did tap
                },
                label: { Text("Click Me") }
            )
      
        }
    }
}


struct StartWorkoutList_Previews: PreviewProvider {
    static var startAction = { }
    static var pauseAction = { }
    static var endAction = { }
    static var previews: some View {
        Group {
            StartWorkoutList(startAction: startAction, pauseAction: pauseAction, endAction: endAction)
            .previewDevice("Apple Watch Series 2 - 40mm")
            .previewDisplayName("40 mm")
            
            StartWorkoutList(startAction: startAction, pauseAction: pauseAction, endAction: endAction)
            .previewDevice("Apple Watch Series 2 - 44mm")
            .previewDisplayName("44 mm")
        }
        
        .environmentObject(WorkoutManager())
        .environmentObject(MotionManager())
    }
}

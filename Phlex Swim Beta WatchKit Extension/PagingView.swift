//
//  PagingView.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//

import SwiftUI
import HealthKit

struct PagingView: View {
    let ExtsnDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    @State var IsEndTheSession: Bool = false
    
    // Page selection enum.
    enum PageSelection {
        case menu // Show the menu page.
        case workout // Show the workout page.
        case reminders // Show the reminders page.
        case smartanalysis // Smart Analysis page
        case statsview // Stats Overview page.
        case chooseWorkout // Choose Workout View
        case mainview // MainView test from nap app
    }
    
    // The business logic.
    //    @EnvironmentObject var workoutSession: WorkoutManager
    // The page you are showing the user.
    @State var pageSelection: PageSelection = .workout
    // Tracks whether a workout is in progress (paused or running), or not.
    @Binding var workoutInProgress: Bool
    
    var body: some View {
        // A Page style tab view.
        
        if #available(watchOSApplicationExtension 7.0, *) {
            TabView(selection: $pageSelection) {
                // The menu view.
                MenuView(pauseAction: pauseAction, endAction: endAction)
                    .tag(PageSelection.menu)
                // The workout view.
                TestWorkoutDashboard()
                    .tag(PageSelection.workout)
                
                //                //Profile view
                //                ScrollView{
                //                    ProfileStatsView()
                //                        .tag(PageSelection.statsview)
                //                }
            }.navigationBarHidden(true)
            .tabViewStyle(PageTabViewStyle())
        } else {
            // Fallback on earlier versions
        }
        
        NavigationLink(destination: CompleteWorkout_View(), isActive : $IsEndTheSession) {
        }
        .buttonStyle(PlainButtonStyle())
        
    }
    func startAction() {
        ExtsnDelegate.workoutSession.startWorkout()
        withAnimation {
            workoutInProgress = true
        }
    }
    
    
    // Callback provided to the pause menu button.
    func pauseAction() {
        withAnimation { self.pageSelection = .workout }
        ExtsnDelegate.workoutSession.togglePause()
    }
    
    // Callback provided to the end workout menu button.
    func endAction() {
        
        print("PageView got endAction()")
        // End the workout.
        ExtsnDelegate.workoutSession.endWorkout()
        
        IsEndTheSession = true
        // Make sure you arrive back on the WorkoutView the next time a workout starts.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.pageSelection = .workout
        }
        // Bring up StartView.
        workoutInProgress = false
    }
}

struct PagingView_Previews: PreviewProvider {
    @State static var workoutInProgress = true
    static var previews: some View {
        Group {
            PagingView(pageSelection: .menu, workoutInProgress: $workoutInProgress)
                .previewDisplayName("pageSelection: .menu")
            
            PagingView(pageSelection: .workout, workoutInProgress: $workoutInProgress)
                .previewDisplayName("pageSelection: .workout")
            
        }
        .environmentObject(WorkoutManager())
        .environmentObject(MotionManager())
    }
}

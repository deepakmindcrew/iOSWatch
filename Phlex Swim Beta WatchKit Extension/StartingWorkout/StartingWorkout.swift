//
//  StartingWorkout.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI
import CoreMotion
import HealthKit

struct StartingHRWorkout: View {
    // Get the business logic from the environment.
    @EnvironmentObject var workoutSession: WorkoutManager
    let motionManager = CMMotionManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    // This view will show an overlay when we don't have a workout in progress.
    @State var workoutInProgress = false
    
    // We need the screen height to know how far to offset the RUN button when the workout is in progress.
    let screenHeight = WKInterfaceDevice.current().screenBounds.size.height
    
    var body: some View {
        VStack{
            HRPagingView(workoutInProgress: self.$workoutInProgress)
                .opacity(self.workoutInProgress ? 1 : 0)
                .animation(.easeInOut(duration: 0.3))
                .overlay( // Overlay the StartView when a workout is not in progress.
            ExplainHRWorkout(startAction: startAction)
                .offset(CGSize(width: 0, height: self.workoutInProgress ? self.screenHeight : 0))
                .animation(.easeInOut(duration: 0.3)))
        }.navigationBarTitle(Text(""))
        .edgesIgnoringSafeArea(.all)
    }
    
    
    
    
    func startAction() {
        workoutSession.checkAuthorization()
        workoutSession.startWorkout()
        withAnimation {
            workoutInProgress = true
        }
    }
}

struct HRPagingView: View {
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
            @EnvironmentObject var workoutSession: WorkoutManager
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
                        
                        //
                        //            // Main View
                        //            MainViewer()
                        // The workout view.
                        HeartRateWkt(pauseAction: pauseAction, endAction: endAction)
                                .tag(PageSelection.workout)
                            //
                            //                GuidedView()
                            //                    .tag(PageSelection.workout)
                        
                        
                        //            RemindersView()
                        //                .tag(PageSelection.reminders)
                        //
                        //            SmartAnalysis()
                        //                .tag(PageSelection.smartanalysis)
                        //
                            ProfileStatsView()
                                .tag(PageSelection.statsview)
                        
                    }.edgesIgnoringSafeArea(.all).navigationBarTitle(Text(""))
                    .tabViewStyle(PageTabViewStyle())
                } else {
                    // Fallback on earlier versions
                }
            }
            func startAction() {
                
                workoutSession.startWorkout()
                withAnimation {
                    workoutInProgress = true
                }
            }
    

            
            // Callback provided to the pause menu button.
            func pauseAction() {
                withAnimation { self.pageSelection = .workout }
                workoutSession.togglePause()
            }
            
            // Callback provided to the end workout menu button.
            func endAction() {
                print("PageView got endAction()")
                // End the workout.
                workoutSession.endWorkout()
                
                // Make sure you arrive back on the WorkoutView the next time a workout starts.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.pageSelection = .workout
                }
                // Bring up StartView.
                workoutInProgress = false
            }
        }
    

struct ExplainHRWorkout: View {
    @State var workoutInProgress = false
    let startAction: (() -> Void)? // The start action callback.

    var body: some View{
        VStack{
            VStack(alignment: .center){
                Text("Heart Rate")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.lightBlue)
                
                
                    
                Text("This is a Heart Rate Workout. Havent implemented GPS yet.")
                            .fixedSize(horizontal: false, vertical: true).font(.system(size: 12, weight: .medium))
                            .foregroundColor(ColorManager.iron)
                    
                }
                    SwimButton(action: {
                        self.startAction!() // FixMe!
                    })
                    }.padding(.top, 50).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(""))
                
}
}


struct ExplainHRWorkout_Previews: PreviewProvider {
    static var startAction = { }
    static var previews: some View {
        ExplainHRWorkout(startAction: startAction)
    }
}

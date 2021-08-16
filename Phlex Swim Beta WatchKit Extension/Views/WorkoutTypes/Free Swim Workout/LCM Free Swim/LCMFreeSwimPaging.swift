//
//  FreeSwimPaging.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI
import CoreMotion
import HealthKit

struct LongFreeSwimPaging: View {
    // Get the business logic from the environment.
    @EnvironmentObject var workoutSession: WorkoutManager
    let motionManager = CMMotionManager()
    
    // This view will show an overlay when we don't have a workout in progress.
    @State var workoutInProgress = false
    
    // We need the screen height to know how far to offset the RUN button when the workout is in progress.
    let screenHeight = WKInterfaceDevice.current().screenBounds.size.height
    
    var body: some View {
        VStack{
            LCMFreeSwimPagingView(workoutInProgress: self.$workoutInProgress)
                .opacity(self.workoutInProgress ? 1 : 0)
                .animation(.easeInOut(duration: 0.3))
                .overlay( // Overlay the StartView when a workout is not in progress.
            LCMExplainFSWorkout(startAction: startAction)
                .offset(CGSize(width: 0, height: self.workoutInProgress ? self.screenHeight : 0))
                .animation(.easeInOut(duration: 0.3)))
        }.navigationBarTitle(Text(""))
        .edgesIgnoringSafeArea(.all)
    }
    
    
    
    
    func startAction() {
        workoutSession.checkAuthorization()
        workoutSession.LCMstartWorkout()
        withAnimation {
            workoutInProgress = true
        }
    }
}

struct LCMFreeSwimPagingView: View {
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
                
                // MARK: - Removed tab view so that WatchOS6 can be supported, need to support the if available protocol eventually.
                // A Page style tab view.
//                if #available(watchOSApplicationExtension 7.0, *) {
//                    TabView(selection: $pageSelection) {
//                        // The menu view.
//                        MenuView(pauseAction: pauseAction, endAction: endAction)
//                            .tag(PageSelection.menu)
                        
                        //
                        //            // Main View
                        //            MainViewer()
                        // The workout view.
                        LCMFreeSwimWorkout(pauseAction: pauseAction, endAction: endAction)
                                .tag(PageSelection.workout)
                            //
                            //                GuidedView()
                            //                    .tag(PageSelection.workout)
                        
                        
                        //            RemindersView()
                        //                .tag(PageSelection.reminders)
                        //
                        //            SmartAnalysis()
//                        //                .tag(PageSelection.smartanalysis)
//                        //
//                            ProfileStatsView()
//                                .tag(PageSelection.statsview)
//
//                    }.edgesIgnoringSafeArea(.all).navigationBarTitle(Text(""))
//                    .tabViewStyle(PageTabViewStyle())
//                }
                    // Fallback on earlier versions
                
            }
            func startAction() {
                workoutSession.SCMstartWorkout()
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
    

struct LCMExplainFSWorkout: View {
    @State var workoutInProgress = false
    let startAction: (() -> Void)? // The start action callback.
    @State var isLCM = false // toggle state
    @State var isSCM = false // toggle state
    @State var isSCY = false // toggle state


    var body: some View{
        VStack{
            VStack(alignment: .center){
                Text("50M LCM")
                    .font(.system(size: 25, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.lightBlue)
                
                
                    
                Text("This is a 50M Long Course workout. Eventually you can choose the distance.")
                            .fixedSize(horizontal: false, vertical: true).font(.system(size: 12, weight: .medium))
                            .foregroundColor(ColorManager.iron)
                    
                }
                    SwimButton(action: {
                        self.startAction!() // FixMe!
                    })
                    }.padding(.top, 50).edgesIgnoringSafeArea(.all).navigationBarTitle(Text(""))
        }
}



struct LCMFreeSwimPaging_Previews: PreviewProvider {
    static var startAction = { }

    static var previews: some View {
        LCMExplainFSWorkout(startAction: startAction)
    }
}

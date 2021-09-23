//
//  testview.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 10/02/21.
//

import Foundation
import SwiftUI

struct PagerBaseView  : View {
    @State var workoutInProgress = true
    let screenHeight = WKInterfaceDevice.current().screenBounds.size.height
    var detail : Base_home_view = Base_home_view()
    @EnvironmentObject var workoutSession5: WorkoutManager
    
    var body: some View{
        
        PagingView(workoutInProgress: self.$workoutInProgress)
            .opacity(self.workoutInProgress ? 1 : 0)
            .animation(.easeInOut(duration: 0.3))
            .overlay( // Overlay the StartView when a workout is not in progress.
                TestWorkoutDashboard()
                    .offset(CGSize(width: 0, height: self.workoutInProgress ? self.screenHeight : 0))
                    .animation(.easeInOut(duration: 0.3)))
            .onAppear {
                self.detail.startAction()
            }
    }
}

//
//  HostingController.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/16/20.
//

import WatchKit
import Foundation
import SwiftUI
import Combine
import HealthKit
import CoreMotion



class HostingController: WKHostingController<AnyView> {
    
    var workoutManager = WorkoutManager()
  
    override var body: AnyView {
        return AnyView(ContentView().environmentObject(workoutManager))
    }
}

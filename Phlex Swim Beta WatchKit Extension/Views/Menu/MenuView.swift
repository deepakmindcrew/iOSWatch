//
//  MenuView.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var workoutSession: WorkoutManager
    
    @State var workoutPaused: Bool = false // Internal workout state.
    let pauseAction: (() -> Void) // Callback to toggle pausing / resuming a workout.
    let endAction: (() -> Void) // Callback to end a workout.
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    
    var body: some View {
        VStack(spacing : 20) {
            
            HStack(alignment: .center) {
                Spacer()
                
                
                //MARK:- Water lock
                Button(action: {
                    if #available(watchOSApplicationExtension 6.1, *) {
                        WKInterfaceDevice.current().enableWaterLock()
                    } else {
                        // Fallback on earlier versions
                    }
                }, label: {
                    Image("WaterLock")
                }).foregroundColor(ColorManager.lightBlue)
                .padding(.leading, 6)
                .buttonStyle(PlainButtonStyle())
                Spacer()
                
                
                //MARK:- Session end
                Button(action: {
                    self.endAction()
                    self.workoutPaused = false
                }, label: {
                    Image("close")
                }).foregroundColor(ColorManager.lightBlue)
                .padding(.leading, 6)
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            
            //MARK:- settings
            HStack(alignment: .center) {
                // The button that end a workout.
                Spacer()
                
                Button(action: {
                }, label: {
                    Image("settings")
                }).foregroundColor(ColorManager.lightBlue)
                .padding(.leading, 6)
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                //MARK:- Pause the session
                // The button that pauses and resumes a workout.
                Button(action: {
                    print("Pause tapped!")
                    self.workoutPaused.toggle()
                    
                    self.pauseAction()
                }, label: {
                    Image("pause")
                }).foregroundColor(ColorManager.lightBlue)
                .padding(.leading, 6)
                .buttonStyle(PlainButtonStyle())                
                Spacer()
            }
            
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var pauseAction = { }
    static var endAction = { }
    
    static var previews: some View {
        
        Group {
            //            MenuView(pauseAction: pauseAction, endAction: endAction)
            //            .previewDevice("Apple Watch Series 3 - 38mm")
            //            .previewDisplayName("38 mm")
            //
            //            MenuView(pauseAction: pauseAction, endAction: endAction)
            //            .previewDevice("Apple Watch Series 5 - 40mm")
            //            .previewDisplayName("40 mm")
            
            MenuView(pauseAction: pauseAction, endAction: endAction)
                .previewDevice("Apple Watch Series 5 - 44mm")
                .previewDisplayName("44 mm")
        }
        
        .environmentObject(WorkoutManager())
        .environmentObject(MotionManager())
        
    }
}

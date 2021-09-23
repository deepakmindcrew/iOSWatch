//
//  TestWorkoutDashboard.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 05/02/21.
//

import SwiftUI
import Combine
import CoreMotion
import Foundation

struct TestWorkoutDashboard: View {
    var body: some View {
        TestWorkoutDashboard_MainView()
    }
}

// MARK: Supporting Structs for workouts scroll
struct TestWorkoutDashboard_Previews: PreviewProvider {
    static var previews: some View {
        TestWorkoutDashboard()
            .environmentObject(WorkoutManager())
            .environmentObject(MotionManager())
    }
}

struct TestWorkoutDashboard_MainView: View {
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    let queue = OperationQueue()
    @EnvironmentObject var motionManager: MotionManager
    let currentFrequency = 60
    let screenWidth = WKInterfaceDevice.current().screenBounds.size.width
    @State var timer2 = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var floatValue = 0.0
    @State private var str_timer = "0:0"
    @State private var counter = 1
    @State private var isSaevdStartTime = true
    @State private var ExersiseTime : Double = 100
    @State private var reducingTimer = 0.0
    @State private var isSessonEndNow = false
    @State private var restTime = 0
    @State private var TempStrockValue = 0.0
    @State private var str_RestTimer = "0:0"
    @State private var tempp = 0
    
    
    var body: some View {
        ScrollView{
            VStack {
                HStack(alignment: .center){
                    ZStack {
                        Group {
                            PercentageRing(
                                ringWidth: 8, percent: ExersiseTime ,
                                backgroundColor: ColorManager.darker.opacity(0.4),
                                foregroundColors: [Color(#colorLiteral(red: 0.4757325649, green: 0.8559685349, blue: 1, alpha: 1)) ,Color(#colorLiteral(red: 0.5607843137, green: 0.8862745098, blue: 0.9058823529, alpha: 1))]
                            )
                            Image("diamond")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color(#colorLiteral(red: 0.2078431373, green: 0.831372549, blue: 0.9058823529, alpha: 1)))
                                .frame(width: 35, height: 35)
                            
                        }.frame(width: 65).padding(.leading)
                    }
                    
                    Spacer()
                    
                    //TestWorkoutDashboard_MainWorkoutStats()
                    VStack(alignment: .center){
                        // The active calories burned.
                        Text("\(floatValue, specifier: "%.f") cal")
                            .font(Font.system(size: 20, weight: .medium, design: .rounded).monospacedDigit())
                            .frame(alignment: .leading)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .foregroundColor(ColorManager.DarkYellow)
                            .onReceive(timer2) { time in
                                self.floatValue = myDelegate.workoutSession.activeCalories
                                
                                if tempp <= Int(myDelegate.workoutSession.distance){
                                    tempp = Int(myDelegate.workoutSession.distance)
                                    myDelegate.SwimDistance = Int(myDelegate.workoutSession.distance)
                                }
                                
                                if ((myDelegate.workoutSession.heartrate) > 60.0) && ((myDelegate.workoutSession.heartrate) < 95.0){
                                    restTime += 1
                                    str_RestTimer = "\(elapsedTimeString2(elapsed: secondsToHoursMinutesSeconds2(seconds: restTime)))"

                                }

//                                if myDelegate.workoutSession.isResting == true{
//                                    restTime += 1
//                                    str_RestTimer = "\(elapsedTimeString2(elapsed: secondsToHoursMinutesSeconds2(seconds: restTime)))"
//                                }
                            }
                        
                        // The distance traveled.
                        Text("\(myDelegate.workoutSession.distance, specifier: "%.f") yd")
                            .font(Font.system(size: 20, weight: .medium, design: .rounded).monospacedDigit())
                            .foregroundColor(ColorManager.Green)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        
                        // The current heartrate.
                        HStack {
                            Text("\(myDelegate.workoutSession.heartrate, specifier: "%.f")")
                                .font(Font.system(size: 20, weight: .medium, design: .rounded).monospacedDigit())
                                .foregroundColor(ColorManager.Red)
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .animation(.interactiveSpring())
                        }
                    }
                    .padding(.trailing, 10)
                }
                .frame(width: (screenWidth), height: 70, alignment: .leading)
                
                // MARK: Workout Guidance Row. Ring fills with amount of time during expected activity, inside shows the interval, right side says what actual activity is being done.
                VStack(){
                    Text("Now")
                        .frame(width: (screenWidth - 15), height: 20, alignment: .leading)
                        .foregroundColor(ColorManager.realWhite)
                        .font(Font.system(size: 18, weight: .bold))
                }
                
                HStack() {
                    ZStack {
                        PercentageRing(
                            ringWidth: 8, percent: 100 ,
                            backgroundColor: ColorManager.darker.opacity(0.4),
                            foregroundColors: [Color(#colorLiteral(red: 0.4757325649, green: 0.8559685349, blue: 1, alpha: 1)) ,Color(#colorLiteral(red: 0.5607843137, green: 0.8862745098, blue: 0.9058823529, alpha: 1))]
                        )
                        Text("1 Min")
                            .foregroundColor(ColorManager.lightBlue)
                            .font(Font.system(size: 14))
                            .fontWeight(.bold)
                        
                    }.frame(width: 65).padding(.leading, 7)
                    Spacer()
                    
                    VStack(alignment: .center){
                        Text("REST")
                            .foregroundColor(ColorManager.lightBlue)
                            .font(.system(size: 18, weight: .bold))
                            .frame(alignment: .leading)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)

//                        Text("\(self.str_timer)")

                        Text("\(self.str_RestTimer)")
                            .frame(alignment: .leading)
                            .font(Font.system(size: 18, weight: .semibold, design: .rounded).monospacedDigit())
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .onReceive(timer2) { time in
                                self.str_timer = "\(elapsedTimeString2(elapsed: secondsToHoursMinutesSeconds2(seconds: myDelegate.workoutSession.elapsedSeconds)))"
                            }
                            
                            .onChange(of: self.str_timer, perform: {newValue in
                                                            
                                
                                if isSaevdStartTime == true {
                                    
                                    isSaevdStartTime = false
                                    UserDefaults.standard.set(Date(), forKey: "WorkoutStartTime")
                                    reducingTimer = Double(myDelegate.selectedMint * 15 * 60)
                                }
                                
                                if reducingTimer > 0.0 {
                                    
                                    reducingTimer -= 1
                                    ExersiseTime = (reducingTimer / Double(myDelegate.selectedMint * 15 * 60) * 100.0)
                                    
                                } else {
                                    myDelegate.workoutSession.isWorkoutPause = false
                                    self.timer2.upstream.connect().cancel()
                                    isSessonEndNow = true
                                    myDelegate.workoutSession.endWorkout()
                                }
                            })
                    }
                }
                .frame(width: (screenWidth), height: 70, alignment: .leading)
                
                if isSessonEndNow == true {
                    
                    NavigationLink(destination: CompleteWorkout_View(), isActive : $isSessonEndNow) {
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
//    // Convert the seconds into seconds, minutes, hours.
func secondsToHoursMinutesSeconds2 (seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

//    // Convert the seconds, minutes, hours into a string.
func elapsedTimeString2(elapsed: (h: Int, m: Int, s: Int)) -> String {
    return String(format: "%d:%02d:%02d", elapsed.h, elapsed.m, elapsed.s)
}


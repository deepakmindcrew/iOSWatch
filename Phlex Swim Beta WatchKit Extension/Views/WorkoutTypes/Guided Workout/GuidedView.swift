//
//  GuidedView.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/22/20.
// CM Implementation currenlty from here https://stackoverflow.com/questions/62020407/swiftui-and-core-motion

import SwiftUI
import Combine
import CoreMotion
import Foundation


struct GuidedView: View {
    var body: some View {
        MainView()
        
    }
}

// MARK: Supporting Structs for workouts scroll
struct GuidedView_Previews: PreviewProvider {
    static var previews: some View {
        GuidedView()
            .environmentObject(WorkoutManager())
            .environmentObject(MotionManager())
    }
}

struct MainView: View {
    @EnvironmentObject var workoutSession: WorkoutManager
    let queue = OperationQueue()
    @EnvironmentObject var motionManager: MotionManager
    let currentFrequency = 60
    
    
    var body: some View {
        //        ScrollView(.vertical, showsIndicators: true)
        VStack {
            HStack(alignment: .center){
                
                RingFiller()
                
                Spacer()
                MainWorkoutStats()
                    .padding(.leading, 5)
            }                .offset(y: 30)
            
            // MARK: Workout Guidance Row. Ring fills with amount of time during expected activity, inside shows the interval, right side says what actual activity is being done.
            
            .padding(.top, 20.0)
            
            
            HStack(alignment: .center) {
                ZStack {
                    
                    PercentageRing(
                        ringWidth: 8, percent: 60 ,
                        backgroundColor: ColorManager.darker.opacity(0.4),
                        foregroundColors: [Color(#colorLiteral(red: 0.4757325649, green: 0.8559685349, blue: 1, alpha: 1)) ,Color(#colorLiteral(red: 0.5607843137, green: 0.8862745098, blue: 0.9058823529, alpha: 1))]
                    )
                    Text("1 Min")
                        .foregroundColor(ColorManager.lightBlue)
                        .font(Font.system(size: 14))
                        .fontWeight(.bold)
                    
                }.frame(width: 60).padding(.leading, 15)
                Spacer()
                VStack(alignment: .center){
                    Text("Rest")
                        .foregroundColor(ColorManager.lightBlue)
                        .font(.system(size: 24, weight: .bold))
                    Text("\(elapsedTimeString(elapsed: secondsToHoursMinutesSeconds(seconds: workoutSession.elapsedSeconds)))")
                        .frame(alignment: .leading)
                        .font(Font.system(size: 24, weight: .semibold, design: .rounded).monospacedDigit())
                }.padding(.trailing, 15)
                
            }
            
            
            
            // MARK: Detailed workout view. UI decision needs to be made. Is it scrollable, modal, sheet? Needs to have broken down overview of the workout in warm up/main set/warm down structure.
            // MARK: Need to figure out how to color highlight main parts of the workout headers/distances
            //Pitch and yaw data here for now, this will be workouts
            
        }.edgesIgnoringSafeArea(.all)//.onappear
    }
}
// Convert the seconds into seconds, minutes, hours.
func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

// Convert the seconds, minutes, hours into a string.
func elapsedTimeString(elapsed: (h: Int, m: Int, s: Int)) -> String {
    return String(format: "%d:%02d:%02d", elapsed.h, elapsed.m, elapsed.s)
}


struct RingFiller: View {
    var body: some View {
        ZStack {
            Group {
                PercentageRing(
                    ringWidth: 8, percent: 90 ,
                    backgroundColor: ColorManager.darker.opacity(0.4),
                    foregroundColors: [Color(#colorLiteral(red: 0.4757325649, green: 0.8559685349, blue: 1, alpha: 1)) ,Color(#colorLiteral(red: 0.5607843137, green: 0.8862745098, blue: 0.9058823529, alpha: 1))]
                )
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(#colorLiteral(red: 0.2078431373, green: 0.831372549, blue: 0.9058823529, alpha: 1)))
                    .frame(width: 25, height: 40)
                
            }.frame(width: 60).padding(.leading, 15)
        }
    }
}

struct MainWorkoutStats: View {
    @EnvironmentObject var workoutSession: WorkoutManager
    
    var body: some View {
        VStack(alignment: .trailing){
            // The active calories burned.
            Text("\(workoutSession.activeCalories, specifier: "%.f") cal")
                .font(Font.system(size: 22, weight: .medium, design: .rounded).monospacedDigit())
                .frame(alignment: .leading)
                .lineLimit(1)
                .foregroundColor(ColorManager.DarkYellow)
            
            
            // The distance traveled.
            Text("\(workoutSession.distance, specifier: "%.f") yd")
                .font(Font.system(size: 22, weight: .medium, design: .rounded).monospacedDigit())
                .foregroundColor(ColorManager.Green)
            
            // The current heartrate.
            HStack {
                Text("\(workoutSession.heartrate, specifier: "%.f")")
                    .font(Font.system(size: 22, weight: .medium, design: .rounded).monospacedDigit())
                    .foregroundColor(ColorManager.Red)
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .animation(.interactiveSpring())
            }
            
            //            // The distance traveled.
            //            Text("\(workoutSession.swimstroke, specifier: "%.f") st")
            //                    .font(Font.system(size: 22, weight: .medium, design: .rounded).monospacedDigit())
        }
    }
}


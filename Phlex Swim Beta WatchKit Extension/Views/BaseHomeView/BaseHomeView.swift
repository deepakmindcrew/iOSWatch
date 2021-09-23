//
//  BaseHomeView.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 04/02/21.
//

import SwiftUI
import Foundation
import Combine

struct Base_home_view : View {
    @State var workoutInProgress = false
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    @State var str_Skills = "No view for\nSkills & Drills"
    @State var str_WaterMode = "No view for\nOpen Water Mode"
    @State var str_WeightLoss = "No view for\nWeight Loss"
    @State var str_FreeSwim = "No view for\nFree Swim"
    
    var body: some View{
        
        NavigationView {
            List{
                
                NavigationLink(destination: TestWorkoutInitialPager_View()) {
                    VStack(alignment : .leading){
                        Text("Workout of the day").font(.headline)
                            .lineLimit(2)
                        
                        Text("Speed focus")
                            .font(Font.system(size: 12, weight: .medium, design: .rounded))
                            .lineLimit(0)
                    }
                }
                .listRowPlatterColor(ColorManager.BlueNew)
                
                
                NavigationLink(destination: EmptyView(resetView: $str_Skills)) {
                    VStack(alignment : .leading){
                        Text("Skills & Drills").font(.headline)
                            .lineLimit(2)
                        
                        Text("Individual Medley work")
                            .font(Font.system(size: 12, weight: .medium, design: .rounded))
                            .lineLimit(2)
                    }
                }
                .listRowPlatterColor(ColorManager.darkblue)
                
                NavigationLink(destination: EmptyView(resetView: $str_WaterMode)) {
                    VStack(alignment : .leading){
                        Text("Open Water Mode").font(.headline)
                            .lineLimit(2)
                        
                        Text("GPS and tracking for accuracy")
                            .font(Font.system(size: 12, weight: .medium, design: .rounded))
                            .lineLimit(2)
                    }
                }
                .listRowPlatterColor(ColorManager.Red)
                
                
                NavigationLink(destination: EmptyView(resetView: $str_WeightLoss)) {
                    VStack(alignment : .leading){
                        Text("Weight Loss").font(.headline)
                            .lineLimit(0)
                        
                        Text("Accomplish your fitness goals")
                            .font(Font.system(size: 12, weight: .medium, design: .rounded))
                            .lineLimit(2)
                    }
                }
                .listRowPlatterColor(ColorManager.DarkYellow)
                
                
                NavigationLink(destination: EmptyView(resetView: $str_FreeSwim)) {
                    VStack(alignment : .leading){
                        Text("Free Swim").font(.headline)
                            .lineLimit(0)
                        
                        Text("Accomplish your fitness goals")
                            .font(Font.system(size: 12, weight: .medium, design: .rounded))
                            .lineLimit(2)
                    }
                }
                .listRowPlatterColor(ColorManager.Green)
                
            }
            .navigationBarTitle("Pick a Workout")
            .onAppear(){
                myDelegate.workoutSession.requestAuthorization()
            }
            
        }.navigationBarHidden(true)
    }
    
    func startAction() {
        
        myDelegate.workoutSession.startWorkout()
        //        workoutSession2.startWorkout()
        withAnimation {
            workoutInProgress = true
        }
    }
}

struct BaseHomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Base_home_view()
    }
}



class NavigationHelper: ObservableObject {
    @Published var selection: String? = nil
}

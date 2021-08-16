//
//  TestWorkoutInitialPager.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 04/02/21.
//

import SwiftUI
import Foundation
import Combine
import HealthKit

struct TestWorkoutInitialPager_View : View {
    @State var str_PulLength: String = "25"
    @State var str_ActivityTime: String = "60"
    @State var IsSavePoolData: Bool = false
    @State private var showingAlert = false
    @State var IsClickOnSelectTime: Bool = false
    
    @State var str_alertMsg: String = ""
    let screenWidth = WKInterfaceDevice.current().screenBounds.size.width - 10
    @State private var tapOnPL25y:Bool = true
    @State private var tapOnPL50m:Bool = false
    @State private var tapOnPL25m:Bool = false
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    @State var IsSetTime: Bool = false
    @State private var showTimPicker = false
    
    let healthStore = HKHealthStore()
    
    var body: some View{
        
        NavigationView {
            
            ScrollView{
                VStack(){
                    VStack(alignment: .center){
                        VStack{
                            
                            //Header
                            Text("Guided Workout")
                                .font(.system(size: 14, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(ColorManager.lightBlue)
                                .padding(.all, 10)
                            
                            //Description
                            Text("Description: ").font(.system(size: 12)).foregroundColor(.gray)  + Text("Designed by Olympic Medailists and Coaches, our guided workouts give you the best workout for the time.").font(.system(size: 11)).foregroundColor(ColorManager.lightBlue)
                            Spacer()
                        }
                        
                        VStack(spacing: 5.0){
                            //Text field area for time in mint
                            VStack(alignment: .center, spacing: 5.0) {
                                Text("How long are you swim?")
                                    .font(.system(size: 9))
                                
                                NavigationLink(destination: TimePicker_view(showSelf: $showTimPicker), isActive: $showTimPicker) {
                                    Text(str_ActivityTime)
                                }
                                .font(.system(size : 12, weight : .bold))
                                .frame(width: 60, height: 30, alignment: .center)
                                .background(ColorManager.DarkBlack)
                                .clipShape(Ellipse())
                                .foregroundColor(ColorManager.Green)
                                .buttonStyle(PlainButtonStyle())
                                .onAppear(){
                                    
                                    if IsSetTime == true {
                                        
                                        str_ActivityTime = "\(myDelegate.selectedMint * 15)"
                                        //                                        print(str_ActivityTime)
                                    }else{
                                        IsSetTime = true
                                    }
                                }
                            }
                            
                            .frame(minWidth: 60,
                                   maxWidth: screenWidth,
                                   minHeight: 60,
                                   maxHeight: 105
                            )
                            .background(ColorManager.ShadowBlack)
                            .cornerRadius(10)
                            
                            //Buttons for select pool length
                            VStack(alignment: .center) {
                                Text("What size of the pool?")
                                    .font(.system(size: 9))
                                
                                HStack{
                                    Button("25y", action:  {
                                        self.tapOnPL25y = true
                                        self.tapOnPL50m = false
                                        self.tapOnPL25m = false
                                        self.str_PulLength = "25"
                                    })
                                    .font(.system(size : 10, weight : .bold))
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .background(ColorManager.DarkBlack)
                                    .cornerRadius(25)
                                    .buttonStyle(PlainButtonStyle())
                                    .foregroundColor(tapOnPL25y ? ColorManager.Green : ColorManager.realWhite)
                                    
                                    Button("50m", action:  {
                                        self.tapOnPL25y = false
                                        self.tapOnPL50m = true
                                        self.tapOnPL25m = false
                                        self.str_PulLength = "50"
                                    })
                                    .font(.system(size : 10, weight : .bold))
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .background(ColorManager.DarkBlack)
                                    .cornerRadius(25)
                                    .buttonStyle(PlainButtonStyle())
                                    .foregroundColor(tapOnPL50m ? ColorManager.Green : ColorManager.realWhite)
                                    
                                    Button("25m", action:  {
                                        self.tapOnPL25y = false
                                        self.tapOnPL50m = false
                                        self.tapOnPL25m = true
                                        self.str_PulLength = "25"
                                    })
                                    .font(.system(size : 10, weight : .bold))
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .buttonStyle(PlainButtonStyle())
                                    .background(ColorManager.DarkBlack)
                                    .cornerRadius(25)
                                    .foregroundColor(tapOnPL25m ? ColorManager.Green : ColorManager.realWhite)
                                }.offset(y:5)
                            }.frame(minWidth: 60,
                                    maxWidth: screenWidth,
                                    minHeight: 60,
                                    maxHeight: 65
                            )
                            .background(ColorManager.ShadowBlack)
                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: TestWorkoutStartTimer(), isActive : $IsSavePoolData) {}
                            .buttonStyle(PlainButtonStyle())
                    }
                    
                    //Action for start
                    Button("Start workout", action:  {
                        print("pull length, \(str_PulLength)!")
                        
                        if str_PulLength.isEmpty
                        {
                            self.str_alertMsg = "Please enter the pool lenght!"
                            self.showingAlert = true
                            
                        }else if str_ActivityTime.isEmpty{
                            self.str_alertMsg = "Please enter the swimming time!"
                            self.showingAlert = true
                            
                        }else{
                            self.showingAlert = false
                            //                            let startDate = Date()
                            //                            let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
                            //                            savePL_TimeOnHK(date: modifiedDate, length: 39.0)
                            IsSavePoolData = true
                            
                            //start button
                        }
                        
                    }).foregroundColor(ColorManager.realWhite).frame(width: 120, height: 40, alignment: .center)
                    .background(ColorManager.BlueNew)
                    .cornerRadius(5.0)
                    .padding(.top, 10)
                    .font(.system(size: 12))
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Alert"), message: Text(self.str_alertMsg), dismissButton: .default(Text("Got it!")))
                    }
                }
            }
            .padding(.top, 10.0)
            .navigationBarTitle("Today's workout")
        }
    }
    
    //Write the data to healthkit for batter accurasy
    //    func savePL_TimeOnHK(date: Date, length: Double) {
    //        let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)
    //        let Pulldistanc = HKQuantitySample.init(type: quantityType!,
    //                                                quantity: HKQuantity.init(unit: HKUnit.yard(), doubleValue: length),
    //                                                start: date,
    //                                                end: date + 20)
    //        healthStore.save(Pulldistanc) { success, error in
    //            if (error != nil) {
    //                print("Error: \(String(describing: error))")
    //            }
    //            if success {
    //                IsSavePoolData = true
    //                print("Saved: \(success)")
    //            }
    //        }
    //    }
}

struct TestWorkoutInitialPager_View_Previews: PreviewProvider {
    
    static var previews: some View {
        TestWorkoutInitialPager_View()
    }
}


class nextPage: WKInterfaceController {
    
}

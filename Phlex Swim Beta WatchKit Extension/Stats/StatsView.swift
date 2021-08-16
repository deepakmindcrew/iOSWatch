//
//  StatsView.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//

import SwiftUI
import HealthKit

struct ProfileStatsView: View {
    @State private var currentPage = 5
    
    var body: some View {
        
        ScrollView{
            VStack {
                AnalyticstoShow()
                    .padding(.top, 10)
                
            }.navigationBarHidden(true)
        }
    }
}

struct TrainingLoad: View {
    
    @State private var Dbl_TraininLoad = 0.0

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Training Load")
                    .foregroundColor(ColorManager.lightBlue)
                    .onAppear(){
                        getTrainingLoads()
                    }
                
                Text("\(String(format: "%.2f", Dbl_TraininLoad))") + Text("/10").font(.system(size: 12)).foregroundColor(ColorManager.Dark_Gray)
                Divider()
            }
        }
    }
        
    func getTrainingLoads() {
        let calendar = Calendar.current
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        //read
        let dateStart = UserDefaults.standard.object(forKey: "WorkoutStartTime") as! Date
        let endTime = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: dateStart, end: endTime, options: [])
        
        // Set the anchor to exactly midnight
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        // Generate daily statistics
        var interval = DateComponents()
        interval.day = 1
        
        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: heartRateType,
                                                quantitySamplePredicate: predicate,
                                                options: .discreteAverage,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)
        // Set the results handler
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else { return }
            
            for statistics in statsCollection.statistics() {
                guard let quantity = statistics.averageQuantity() else { continue }
                
                let beatsPerMinuteUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let AVHR = quantity.doubleValue(for: beatsPerMinuteUnit)
                var Zone = 1
                
                if AVHR >= 75 && AVHR <= 100{
                    Zone = 1
                }else if AVHR > 100 && AVHR <= 120{
                    Zone = 2

                }else if AVHR > 120 && AVHR <= 140{
                    Zone = 3

                }else if AVHR > 140 && AVHR <= 160{
                    Zone = 4

                }else if AVHR > 160 && AVHR <= 180{
                    Zone = 5
                }
                
                let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: dateStart, to: endTime)
                let hours = diffComponents.hour ?? 0
                let minutes = diffComponents.minute ?? 0
                var FinalMinut = minutes
                if hours > 0{
                    FinalMinut += (hours)*60
                    
                }else{
                    FinalMinut = minutes
                }
                
                Dbl_TraininLoad = Double(Double(FinalMinut * Zone)/45.0)
                print("Training load------------------------- \(Dbl_TraininLoad)")
                print(String(format: "%.2f", Dbl_TraininLoad))

            }
        }
        
        HKHealthStore().execute(query)
    }
}

struct AverageHeartRate: View {
    @State private var str_AVGHeartValue = "92"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Average Heart Rate")
                    .foregroundColor(ColorManager.lightBlue)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .onAppear(){
                        AvgHeartRate()
                    }
                Text(str_AVGHeartValue)
                    .font(.system(size: 36))
                Text("92 ").font(.system(size: 12)).foregroundColor(.gray) + Text("Max HR").font(.system(size: 12)).foregroundColor(ColorManager.Dark_Gray)
                
                Text("Primary Zone: ").font(.system(size: 12)).foregroundColor(ColorManager.Dark_Gray) +                 Text("Anaerobic")
                    .font(.system(size: 12))
                    .foregroundColor(ColorManager.Green)
                Divider()
            }
        }
    }
    
    
    func AvgHeartRate() {
        let calendar = Calendar.current
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        //read
        let dateStart = UserDefaults.standard.object(forKey: "WorkoutStartTime") as! Date
        let endTime = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: dateStart, end: endTime, options: [])
        
        // Set the anchor to exactly midnight
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        // Generate daily statistics
        var interval = DateComponents()
        interval.day = 1
        
        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: heartRateType,
                                                quantitySamplePredicate: predicate,
                                                options: .discreteAverage,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)
        // Set the results handler
        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else { return }
            
            for statistics in statsCollection.statistics() {
                guard let quantity = statistics.averageQuantity() else { continue }
                
                let beatsPerMinuteUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let value = quantity.doubleValue(for: beatsPerMinuteUnit)
                
                str_AVGHeartValue = String(Int(value))
            }
        }
        
        HKHealthStore().execute(query)
    }
    
}

struct TotalDistance: View {
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Total Distance")
                    .foregroundColor(ColorManager.lightBlue)
                HStack(alignment: .bottom) {
                    Text((String(format: "%.2f", (Float(myDelegate.SwimDistance) * 0.0009144))))
                        .font(.system(size: 20))
                        .onAppear(){
                            print("Deepak-------\(myDelegate.SwimDistance)")
                        }
                    
                    Text(" km")
                        .font(.system(size: 14))
                        .offset(x: -6,y: -5)
                        
                        .foregroundColor(ColorManager.Dark_Gray)
                }
                Divider()
            }
        }
    }
}

struct AvgStrokeCount: View {
    var avrStrock : Int = 0
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    @State private var str_AVGStrokValue = "0"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Avg Stroke Count")
                        .foregroundColor(ColorManager.lightBlue)
                        .onAppear(){
                            querySwimStrokeCount()
                        }
                    
                    HStack(alignment: .bottom){
                        
                        Text(str_AVGStrokValue)
                            .font(.system(size: 24))
                        
                        Text(" Strk Per Lap")
                            .font(.system(size: 14))
                            .foregroundColor(ColorManager.Dark_Gray)
                            .offset(x: -5, y: -2)
                    }
                }
            }
            Divider()
        }
    }
    
    func querySwimStrokeCount() {
        var totalStrockCount : Int = 1
        var numbOfStrock : Int = 0
        
        //read
        let dateStart = UserDefaults.standard.object(forKey: "WorkoutStartTime") as! Date
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        
        let endTime = Date()
        //        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: startTime)!
        
        let sampleType = HKSampleType.quantityType(forIdentifier: .swimmingStrokeCount)!
        let sampleDate = HKQuery.predicateForSamples(withStart: dateStart, end: endTime, options: [])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: sampleDate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { query, samplesOrNil, errorOrNil in
            samplesOrNil?.forEach({ sample in
                
                if let quantitySample = sample as? HKQuantitySample {
                    let strokes = quantitySample.quantity.doubleValue(for: HKUnit.count())
                    totalStrockCount += 1
                    numbOfStrock += Int(strokes)
                }
            })
            
            str_AVGStrokValue = String(numbOfStrock/totalStrockCount)
            print( "AVG strock" + str_AVGStrokValue)
        }
        HKHealthStore().execute(query)
    }
}

struct RecoveryScore2: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Recovery Score")
                        .foregroundColor(ColorManager.lightBlue)
                    HStack(alignment: .bottom){
                        
                        Text("73")
                            .font(.system(size: 24))
                        
                        Text(" /100:")
                            .font(.system(size: 12))
                            .foregroundColor(ColorManager.Dark_Gray)
                            .offset(x: -5, y: -2)
                        
                        Text("Avg Recovery")
                            .font(.system(size: 10, weight: .medium))
                            .multilineTextAlignment(.center)
                            .offset(x: -10, y: -2)
                            .foregroundColor(.yellow)
                    }
                }
            }
            Divider()
        }
    }
}

struct ChartView: View {
    var body: some View {
        VStack {
            BarChart()
            Divider()
        }
    }
}

struct DoneButton: View {
    var Obj_InsertData_VM = InsertWorkout_VM()
    @State private var bool_isDone : Bool = false

    var body: some View {
        VStack {
            //Action for start
                        Button("Done", action:  {
                            Obj_InsertData_VM.obj_view = self
                            Obj_InsertData_VM.getallUserData()
//                            bool_isDone = true
                        })
                        .foregroundColor(ColorManager.realWhite).frame(width: 120, height: 40, alignment: .center)
                        .background(ColorManager.BlueNew)
                        .cornerRadius(5.0)
                        .padding(.top, 10)
                        .font(.system(size: 12))

            NavigationLink(destination: Base_home_view(), isActive : $bool_isDone) {
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarHidden(true)
        }
    }
    
    func finishedAPI(){
        DispatchQueue.main.async {
            print("Finished")
            bool_isDone = true

        }
    }

}


struct AnalyticstoShow: View {
    let screenWidth = WKInterfaceDevice.current().screenBounds.size.width
    
    var body: some View {
        VStack {
            
            Text("Week Stats")
                .foregroundColor(ColorManager.lightBlue)
                .font(.system(size: 22, weight : .bold))
                .multilineTextAlignment(.leading)
                .frame(width: screenWidth, height: 10, alignment: .leading)
            Spacer()
            Spacer()
            
            TrainingLoad()
            
            AverageHeartRate()
            
            TotalDistance()
            
            AvgStrokeCount()
            
            RecoveryScore2()
            
            ChartView()
            
            DoneButton()
        }
    }
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            ProfileStatsView()
        }
    }
}

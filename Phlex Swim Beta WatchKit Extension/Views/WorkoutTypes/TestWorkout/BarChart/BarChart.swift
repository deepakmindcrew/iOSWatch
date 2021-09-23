import SwiftUI
import HealthKit

/// Creates a Bar Chart similar to the chart used in iOS Health app
struct BarChart: View {
    
    fileprivate let healthKitManager = HealthKitManager.sharedInstance

    let rainfallData:[Data] = [Data(month: "sun", rainfall: 3.0),
                               Data(month: "mon", rainfall: 2.0),
                               Data(month: "tue", rainfall: 4.0),
                               Data(month: "wed", rainfall: 2.0),
                               Data(month: "thu", rainfall: 3.0),
                               Data(month: "fri", rainfall: 5.0),
                               Data(month: "sat", rainfall: 0.0)]
        
    var body: some View{
        
        VStack(alignment: .leading, spacing: 5){
            Text("Week Stain Graph")
                .foregroundColor(ColorManager.lightBlue)
                .onAppear(){
                    DispatchQueue.main.async {
//                        GetWorkoutsData()
                    }
                }
            HStack(alignment: .bottom, spacing: 5){
                ForEach(0..<7){i in
                    if (self.rainfallData[i].rainfall) == 0.0{
                        BarWithLabel(month: self.rainfallData[i].month, rainfall: CGFloat(5.0), isEmpty: false)
                        
                    }else{
                        BarWithLabel(month: self.rainfallData[i].month, rainfall: CGFloat(self.rainfallData[i].rainfall), isEmpty: true)
                    }
                }
            }
        }
    }
    
    
    // getAllWorkoutTypes
//    func GetWorkoutsData() {
//
//        let workoutTypes :NSMutableArray = healthKitManager.getAllWorkoutTypes()
//
//        for t in workoutTypes {
//
//            let localDict:NSDictionary = t as! NSDictionary
//
//            let idType:HKWorkoutActivityType = localDict.value(forKey: "idType") as! HKWorkoutActivityType
//            let workoutActivityType : String = localDict.value(forKey: "workoutActivityType") as! String
//            let intensityType :Int = localDict.value(forKey: "intensityType") as! Int
//
////            var lastQueriedEndTime = UserDefaults.standard.object(forKey: healthKitManager.HealthDataManagerLastQueriedWorkoutEndDateKey) as? Date
////            if lastQueriedEndTime == nil {
////
////                UserDefaults.standard.setValue(installDate, forKey: healthKitManager.HealthDataManagerLastQueriedWorkoutEndDateKey)
////            }
////
////            lastQueriedEndTime = installDate
//
//            let workoutPredicate = NSPredicate(format: "%K == %lu && %K >= %@", HKPredicateKeyPathWorkoutType, idType.rawValue as CVarArg, HKPredicateKeyPathStartDate, Date() as CVarArg)
//
//
//            // let workoutPredicate = NSPredicate(format: "%K == %lu && %K >= %@", HKPredicateKeyPathWorkoutType, workoutActivityType, HKPredicateKeyPathStartDate, lastQueriedEndTime)
//
//
//            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
//
//            let sampleQuery = HKSampleQuery(sampleType: HKWorkoutType.workoutType(), predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor], resultsHandler: { query, results, error in
//
//                if ((results?.count ?? 0) > 0)
//                {
////                    var newLastQueriedEndTime = self.Last_HealthSync_Date
//
//                    for samples in results! {
//                        // your code here
//                        let workout = samples as! HKWorkout
//                        print("value--\(workout)")
////                        let dictParameter = NSMutableDictionary()
////                        print(dictParameter)
////                        dictParameter.setValue(UTC_DF().string(from: workout.startDate), forKey: "StartTime")
////                        dictParameter.setValue(UTC_DF().string(from: workout.endDate), forKey: "EndTime")
////                        dictParameter.setValue(LocalDF().string(from: Date(timeInterval: TimeInterval(NSTimeZone.system.secondsFromGMT()), since: workout.startDate)) as Any, forKey: "LocalStartTime")
////                        dictParameter.setValue(LocalDF().string(from: Date(timeInterval: TimeInterval(NSTimeZone.system.secondsFromGMT()), since: workout.endDate)) as Any, forKey: "LocalEndTime")
////                        dictParameter.setValue(0 as Any, forKey: "StepCount")
////                        dictParameter.setValue(0 as Any, forKey: "Distance")
////                        dictParameter.setValue(intensityType as Any, forKey: "ActivityTypeFromDevice")
////                        dictParameter.setValue(workoutActivityType as Any, forKey: "Intensity")
////                        dictParameter.setValue("IOS" as Any, forKey: "DeviceType")
////                        dictParameter.setValue(workout.totalEnergyBurned?.doubleValue(for: HKUnit(from: "kcal")) as Any, forKey: "Calories")
////
////                        self.healthDataArray.add(dictParameter)
//
////                        newLastQueriedEndTime = workout.endDate
//                    }
//
////                    self.UploadHealthKitData_InvokeAPI()
//
////                    UserDefaults.standard.setValue(newLastQueriedEndTime, forKey: self.healthKitManager.HealthDataManagerLastQueriedWorkoutEndDateKey)
//                }
//            })
//
////             print("--localDictArr Workout--\(self.healthDataArray)")
//
//            healthKitManager.healthStore?.execute(sampleQuery)
//
//        }
//    }
}


struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart()
    }
}

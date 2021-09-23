//
//  HealthKitManager.swift
//  HealthKitStepsDemo
//
//  Created by Natasha Murashev on 10/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import HealthKit
//import RealmSwift

enum HealthDataWorkoutIntensityType : Int32 {
    case sedentary = 1
    case low
    case moderate
    case vigorous
}

//class TodayActivity : Object {
//
//    @objc dynamic var LocalStairSteps: NSNumber = 0
//    @objc dynamic var StairSteps: NSNumber = 0
//    @objc dynamic var WalkingSteps: NSNumber = 0
//    @objc dynamic var ActivityMinutes: NSNumber = 0
//    @objc dynamic var VigorousMinutes: NSNumber = 0
//    @objc dynamic var ModerateMinutes: NSNumber = 0
//    @objc dynamic var LightMinutes: NSNumber = 0
//    @objc dynamic var SedentryMinutes: NSNumber = 0
//    @objc dynamic var ActivityDate: NSString = ""
//}

//class WeekActivity : Object {
//
//    @objc dynamic var StairSteps: Int32 = 0
//    @objc dynamic var WalkingSteps: Int32 = 0
//    @objc dynamic var ActivityMinutes: Int32 = 0
//    @objc dynamic var TargetMinutes: Int32 = 0
//    @objc dynamic var VigorousMinutes: Int32 = 0
//    @objc dynamic var ModerateMinutes: Int32 = 0
//    @objc dynamic var LightMinutes: Int32 = 0
//    @objc dynamic var SedentryMinutes: Int32 = 0
//    @objc dynamic var ActivityDate: NSString = ""
//}

//class MonthActivity : Object {
//
//    @objc dynamic var StairSteps: Int32 = 0
//    @objc dynamic var WalkingSteps: Int32 = 0
//    @objc dynamic var ActivityMinutes: Int32 = 0
//    @objc dynamic var TargetMinutes: Int32 = 0
//    @objc dynamic var VigorousMinutes: Int32 = 0
//    @objc dynamic var ModerateMinutes: Int32 = 0
//    @objc dynamic var LightMinutes: Int32 = 0
//    @objc dynamic var SedentryMinutes: Int32 = 0
//    @objc dynamic var ActivityDate: NSString = ""
//}

class HealthKitManager {
    
//    var InstallDateKey = "InstallDateKey"
//    var HealthDataManagerLastQueriedStepsEndDateKey = "HealthDataManagerLastQueriedStepsEndDateKey"
//    var HealthDataManagerLastQueriedDistanceEndDateKey = "HealthDataManagerLastQueriedDistanceEndDateKey"
//    var HealthDataManagerLastQueriedBikingDistanceEndDateKey = "HealthDataManagerLastQueriedBikingDistanceEndDateKey"
//    var HealthDataManagerLastQueriedWorkoutEndDateKey = "HealthDataManagerLastQueriedWorkoutEndDateKey"
    var HealthDataManagerUserAuthorizedAppKey = "HealthDataManagerUserAuthorizedAppKey"
    var HealthDataManagerUserAnsweredAuthorizationQuestionKey = "HealthDataManagerUserAnsweredAuthorizationQuestionKey"
    
    var HealthDataWorkoutIntensityTypeVigorous = "Vigorous"
    var HealthDataWorkoutIntensityTypeModerate = "Moderate"
    var HealthDataWorkoutIntensityTypeLow = "Low"
    var HealthDataWorkoutIntensityTypeSedentary = "Sedentary"
    
    var installDate :Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    
    func getAllWorkoutTypes() -> NSMutableArray {
        
        let localArray = NSMutableArray()

//        localArray.add([
//            "idType" : HKWorkoutActivityType.stairClimbing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 1,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.stairs,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 1,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.archery,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 3,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.badminton,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 4,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.baseball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 5,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.basketball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 6,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.cycling,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 8,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.boxing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 15,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.cricket,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 18,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.crossTraining,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 19,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.curling,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 20,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.dance,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 21,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.elliptical,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 24,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.fencing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 27,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.americanFootball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 28,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.australianFootball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 29,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.soccer,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 30,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.golf,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 33,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.gymnastics,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 34,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.handball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 35,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.hiking,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 37,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.hockey,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 38,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.equestrianSports,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 39,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.skatingSports,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 41,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.highIntensityIntervalTraining,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 43,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.jumpRope,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 44,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.paddleSports,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 45,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.kickboxing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 47,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.martialArts,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 49,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.mindAndBody,
//            "workoutActivityType" : "Sedentary",
//            "intensityType" : 50,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.pilates,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 56,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.racquetball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 58,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.climbing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 59,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.rowing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 60,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.rugby,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 62,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.running,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 63,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.sailing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 67,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.crossCountrySkiing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 76,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.downhillSkiing,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 77,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.snowSports,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 80,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.snowboarding,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 86,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.softball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 89,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.squash,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 90,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.functionalStrengthTraining,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 94,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.traditionalStrengthTraining,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 94,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.surfingSports,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 95,
//            ])
        localArray.add([
            "idType" : HKWorkoutActivityType.swimming,
            "workoutActivityType" : "Vigorous",
            "intensityType" : 96,
            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.tableTennis,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 99,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.tennis,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 101,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.volleyball,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 105,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.waterSports,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 108,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.walking,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 109,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.waterPolo,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 114,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.wheelchairWalkPace,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 116,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.wheelchairRunPace,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 116,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.yoga,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 118,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.bowling,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 121,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.fishing,
//            "workoutActivityType" : "Low",
//            "intensityType" : 122,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.hunting,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 123,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.lacrosse,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 124,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.trackAndField,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 125,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.wrestling,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 126,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.play,
//            "workoutActivityType" : "Low",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.preparationAndRecovery,
//            "workoutActivityType" : "Low",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.waterFitness,
//            "workoutActivityType" : "Vigorous",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.barre,
//            "workoutActivityType" : "Low",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.coreTraining,
//            "workoutActivityType" : "Moderate",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.flexibility,
//            "workoutActivityType" : "Low",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.stepTraining,
//            "workoutActivityType" : "Low",
//            "intensityType" : 53,
//            ])
//        localArray.add([
//            "idType" : HKWorkoutActivityType.other,
//            "workoutActivityType" : "Low",
//            "intensityType" : 53,
//            ])
        
        return localArray
    }
    
    class var sharedInstance: HealthKitManager {
        struct Singleton {
            static let instance = HealthKitManager()
        }
        
        return Singleton.instance
    }
    
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    let stepCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    
    let distanceWalkingRunning = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
    
    let flightsClimbed = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)
    
    let distanceCycling = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)
    
    let workoutType = HKQuantityType.workoutType()
    
    let typesToRead : Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: .flightsClimbed)!, HKObjectType.quantityType(forIdentifier: .distanceCycling)!, HKObjectType.workoutType()]
    
    func isHealthDataAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func hasUserAuthorizedAppToAccessHealthData() -> Bool {
        return UserDefaults.standard.bool(forKey: HealthDataManagerUserAuthorizedAppKey)
    }
    
    func hasUserAnsweredAuthorizationQuestion() -> Bool {
        return UserDefaults.standard.bool(forKey: HealthDataManagerUserAnsweredAuthorizationQuestionKey)
    }
    
    func userDidAnswerAuthorizationQuestion() {
        UserDefaults.standard.set(true, forKey: HealthDataManagerUserAnsweredAuthorizationQuestionKey)
        UserDefaults.standard.synchronize()
    }
    
    func userDidRejectAuthorizationForTheApp() {
        UserDefaults.standard.set(false, forKey: HealthDataManagerUserAuthorizedAppKey)
        UserDefaults.standard.synchronize()
    }
    
//    func requestHealthKitAuthorization() {
//
//        self.healthStore?.requestAuthorization(toShare: nil, read: typesToRead, completion: { [unowned self] (success, error) in
//            if ((error != nil))
//            {
//                if success {
////                    DBG("User completed dialog.")
//                    UserDefaults.standard.set(true, forKey: self.HealthDataManagerUserAuthorizedAppKey)
//                    UserDefaults.standard.synchronize()
//
//                    DispatchQueue.main.async(execute: {
//                        self.queryStepsSum()
//
//                        //                        hdm.queryHealthData()
//                    })
//                } else {
////                    DBG("User cancelled dialog.")
//                    UserDefaults.standard.set(false, forKey: self.HealthDataManagerUserAuthorizedAppKey)
//                    UserDefaults.standard.synchronize()
//                }
//            } else {
//                UserDefaults.standard.set(false, forKey: self.HealthDataManagerUserAuthorizedAppKey)
//                UserDefaults.standard.synchronize()
//            }
//        })
//    }
//
//    func queryStepsSum() {
//        let predicate = HKQuery.predicateForSamples(withStart: self.installDate, end: Date(), options: .strictStartDate)
//        let stepsUnit = HKUnit.count()
//
//        let sumOption = HKStatisticsOptions.cumulativeSum
//        let statisticsSumQuery = HKStatisticsQuery(quantityType: stepCount!, quantitySamplePredicate: predicate, options: sumOption) {(query, result, error) in
//            if let sumQuantity = result?.sumQuantity() {
//                let numberOfSteps = Int(sumQuantity.doubleValue(for: stepsUnit))
//
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                let formattedNumber = numberFormatter.string(from: NSNumber(value:numberOfSteps))
//
//                DispatchQueue.main.async {
//
//                    print("Steps : " +  "\(formattedNumber ?? "")")
//
//                    Toast.show(message: ("Steps : " +  "\(formattedNumber ?? "")"), controller: (APPDELEGATE.window!.rootViewController!))
//
//                }
//            } else {
//            }
//        }
//        self.healthStore?.execute(statisticsSumQuery)
//    }
}

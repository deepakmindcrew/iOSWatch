//
//  HealthManager.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//

import Foundation
import HealthKit
import Combine
import SwiftUI

class WorkoutManager: NSObject, ObservableObject {
    
    /// - Tag: DeclareSessionBuilder
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession!
    var builder: HKLiveWorkoutBuilder!
    
    // Publish the following:
    // - heartrate
    // - active calories
    // - swimming distance
    // - elapsed time
    // - swimming stroke count
    // - V02 Max
    
    /// - Tag: Publishers
    @Published var heartrate: Double = 0
    @Published var swimstroke: Double = 0
    @Published var activeCalories: Double = 0
    @Published var distance: Double = 0
    @Published var steps: Double = 0
    @Published var distanceWalking: Double = 0
    @Published var bodytemp: Double = 0
    @Published var basalbody: Double = 0
    @Published var vo2: Double = 0
    @Published var elapsedSeconds: Int = 0
//    @Published var isResting : Bool = false
    
    //Pause related things
    //    @Published var Puse_activeCalories: Double = 0
    //    @Published var Puse_distance: Double = 0
    //    @Published var Puse_heartrate: Double = 0
    @Published var isWorkoutPause : Bool = false
    
    // The app's workout state.
    var running: Bool = false
    
    /// - Tag: TimerSetup
    // The cancellable holds the timer publisher.
    var start: Date = Date()
    var cancellable: Cancellable?
    var accumulatedTime: Int = 0
    
    // Set up and start the timer.
    func setUpTimer() {
        start = Date()
        cancellable = Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedSeconds = self.incrementElapsedTime()
            }
    }
    
    // Calculate the elapsed time.
    func incrementElapsedTime() -> Int {
        let runningTime: Int = Int(-1 * (self.start.timeIntervalSinceNow))
        return self.accumulatedTime + runningTime
    }
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {
        // Requesting authorization.
        /// - Tag: RequestAuthorization
        // The quantity type to write to the health store.
        let typesToShare: Set = [
            HKQuantityType.workoutType(),
            HKQuantityType.quantityType(forIdentifier: .distanceSwimming)!,
            HKQuantityType.quantityType(forIdentifier: .swimmingStrokeCount)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!,
            HKCategoryType.quantityType(forIdentifier: .distanceSwimming)!,
            HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .forcedExpiratoryVolume1)!,
            HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!,
            HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!,
            HKQuantityType.quantityType(forIdentifier: .vo2Max)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        ]
        
        // The quantity types to read from the health store.
        let typesToRead: Set = [
            HKQuantityType.workoutType(),
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceSwimming)!,
            HKQuantityType.quantityType(forIdentifier: .swimmingStrokeCount)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
            HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .forcedExpiratoryVolume1)!,
            HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!,
            HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!,
            HKQuantityType.quantityType(forIdentifier: .vo2Max)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        ]
        
        // Request authorization for those quantity types.
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            // Handle error.
            print(error as Any)
        }
    }
    
    // Check Authorization
    func checkAuthorization() {
        let authorizationStatus = healthStore.authorizationStatus(for: HKObjectType.workoutType())
        if authorizationStatus == HKAuthorizationStatus.sharingAuthorized {
            print("Authorised")
        } else if authorizationStatus == HKAuthorizationStatus.sharingDenied {
            print("Denied")
            self.requestAuthorization()
        } else {
            print("Not determined")
            self.requestAuthorization()
        }
    }
    
    // Provide the workout configuration.
    func workoutConfiguration() -> HKWorkoutConfiguration {
        /// - Tag: WorkoutConfiguration
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .swimming
        configuration.lapLength = HKQuantity(unit: HKUnit.yard(), doubleValue: 25)
        configuration.swimmingLocationType = .pool
        return configuration
    }
    
    func SCMworkoutConfiguration() -> HKWorkoutConfiguration {
        /// - Tag: WorkoutConfiguration
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .swimming
        configuration.lapLength = HKQuantity(unit: HKUnit.meter(), doubleValue: 25)
        configuration.swimmingLocationType = .pool
        return configuration
    }
    
    func LCMworkoutConfiguration() -> HKWorkoutConfiguration {
        /// - Tag: WorkoutConfiguration
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .swimming
        configuration.lapLength = HKQuantity(unit: HKUnit.meter(), doubleValue: 50)
        configuration.swimmingLocationType = .pool
        return configuration
    }
    
    func openWaterWorkoutConfiguration() -> HKWorkoutConfiguration {
        /// - Tag: Open Water Workout Configurator
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .swimming
        configuration.swimmingLocationType = .openWater
        return configuration
    }
    
    func testWorkoutConfiguration() -> HKWorkoutConfiguration {
        /// - Tag: Open Water Workout Configurator
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .walking
        configuration.locationType = .outdoor
        return configuration
    }
    
    // Start the workout.
    func SCMstartWorkout() {
        // Start the timer.
        setUpTimer()
        self.running = true
        
        // Create the session and obtain the workout builder.
        /// - Tag: CreateWorkout
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.SCMworkoutConfiguration())
            builder = session?.associatedWorkoutBuilder()
            
        } catch {
            print(error)
            return
        }
        
        // Setup session and builder.
        session!.delegate = self
        builder!.delegate = self
        
        // Set the workout builder's data source.
        /// - Tag: SetDataSource
        builder!.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                      workoutConfiguration: SCMworkoutConfiguration())
        
        // Start the workout session and begin data collection.
        /// - Tag: StartSession
        session!.startActivity(with: Date())
        builder!.beginCollection(withStart: Date()) { (success, error) in
            // The workout has started.
            print("Short Course Meters 25m")
            print("The Workout Has Started")
        }
    }
    
    // Start the workout.
    func LCMstartWorkout() {
        // Start the timer.
        setUpTimer()
        self.running = true
        
        // Create the session and obtain the workout builder.
        /// - Tag: CreateWorkout
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.LCMworkoutConfiguration())
            builder = session?.associatedWorkoutBuilder()
            
        } catch {
            print(error)
            return
        }
        
        // Setup session and builder.
        session!.delegate = self
        builder!.delegate = self
        
        // Set the workout builder's data source.
        /// - Tag: SetDataSource
        builder!.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                      workoutConfiguration: LCMworkoutConfiguration())
        
        // Start the workout session and begin data collection.
        /// - Tag: StartSession
        session!.startActivity(with: Date())
        builder!.beginCollection(withStart: Date()) { (success, error) in
            // The workout has started.
            print("Long Course Meters 50m")
            print("The Workout Has Started")
        }
    }
    
    // Start the workout.
    func startWorkout() {
        // Start the timer.
        setUpTimer()
        self.running = true
        
        // Create the session and obtain the workout builder.
        /// - Tag: CreateWorkout
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.workoutConfiguration())
            builder = session?.associatedWorkoutBuilder()
            
        } catch {
            print(error)
            return
        }
        
        // Setup session and builder.
        session!.delegate = self
        builder!.delegate = self
        
        // Set the workout builder's data source.
        /// - Tag: SetDataSource
        builder!.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                      workoutConfiguration: workoutConfiguration())
        
        // Start the workout session and begin data collection.
        /// - Tag: StartSession
        session!.startActivity(with: Date())
        builder!.beginCollection(withStart: Date()) { (success, error) in
            // The workout has started.
            print("The Workout Has Started")
        }
    }
    
    // Start the workout.
    func startOWWorkout() {
        // Start the timer.
        setUpTimer()
        self.running = true
        
        // Create the session and obtain the workout builder.
        /// - Tag: CreateWorkout
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.openWaterWorkoutConfiguration())
            builder = session?.associatedWorkoutBuilder()
            
        } catch {
            print(error)
            return
        }
        
        // Setup session and builder.
        session!.delegate = self
        builder!.delegate = self
        
        // Set the workout builder's data source.
        /// - Tag: SetDataSource
        builder!.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                      workoutConfiguration: openWaterWorkoutConfiguration())
        
        // Start the workout session and begin data collection.
        /// - Tag: StartSession
        session!.startActivity(with: Date())
        builder!.beginCollection(withStart: Date()) { (success, error) in
            // The workout has started.
            print("Open Water Workout Started")
        }
    }
    
    // MARK: - Test Workout Type (walk/run)
    // Start the workout.
    func startTestWorkout() {
        
        // Start the timer.
        setUpTimer()
        self.running = true
        
        // Create the session and obtain the workout builder.
        /// - Tag: CreateWorkout
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.testWorkoutConfiguration())
            builder = session?.associatedWorkoutBuilder()
            
        } catch {
            print(error)
            return
        }
        
        // Setup session and builder.
        session!.delegate = self
        builder!.delegate = self
        
        // Set the workout builder's data source.
        /// - Tag: SetDataSource
        builder!.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                      workoutConfiguration: testWorkoutConfiguration())
        
        // Start the workout session and begin data collection.
        /// - Tag: StartSession
        session!.startActivity(with: Date())
        builder!.beginCollection(withStart: Date()) { (success, error) in
            // The workout has started.
            print("Test Workout Started")
        }
    }
    
    // MARK: - State Control
    func togglePause() {
        // If you have a timer, then the workout is in progress, so pause it.
        if running == true {
            self.pauseWorkout()
        } else {// if session.state == .paused { // Otherwise, resume the workout.
            resumeWorkout()
        }
    }
    
    func pauseWorkout() {
        
        isWorkoutPause = true
        session!.end()
        cancellable?.cancel()
        
        accumulatedTime = elapsedSeconds
        running = false
    }
    
    func resumeWorkout() {
        
        let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        myDelegate.workoutSession.startWorkout()
        
    }
    
    func endWorkout() {
        // End the workout session.
        
        session!.end()
        cancellable?.cancel()
    }
    
    func resetWorkout() {
        // Reset the published values.
        DispatchQueue.main.async {
            self.elapsedSeconds = 0
            self.activeCalories = 0
            self.heartrate = 0
            self.distance = 0
            self.distanceWalking = 0
            self.swimstroke = 0
            self.basalbody = 0
            self.vo2 = 0
            self.steps = 0
            self.distanceWalking = 0
            self.bodytemp = 0
            self.isWorkoutPause = false
        }
    }
    
    // MARK: - Update the UI
    // Update the published values.
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }
        
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                /// - Tag: SetLabel
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let value = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                print("DDD--\(self.heartrate) bpm")
                //                self.Puse_heartrate = roundedValue
                self.heartrate = roundedValue
                
            case HKQuantityType.quantityType(forIdentifier: .swimmingStrokeCount):
                /// - Tag: SetLabel
                let strokeUnit = HKUnit.count()
                let value = statistics.sumQuantity()?.doubleValue(for: strokeUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                self.swimstroke = roundedValue

//                if self.swimstroke == roundedValue{
//                    print("DDD---------------Equal strokes-----------------")
//                    self.isResting = true
//                }else{
//                    print("DDD---------------Not ---------------------------Equal strokes")
//                    print("DDD--\(self.swimstroke) strokes")
//                    self.isResting = false
//                }
                
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                let value = statistics.sumQuantity()?.doubleValue(for: energyUnit)
                
                if self.isWorkoutPause == true{
                    self.activeCalories += Double( round( 1 * value! ) / 1 )
                    
                }else{
                    self.activeCalories = Double( round( 1 * value! ) / 1 )
                }
                
                print("DDD--\(self.activeCalories) cals")
                return
                
            case HKQuantityType.quantityType(forIdentifier: .distanceSwimming):
                let yardUnit = HKUnit.yard()
                let value = statistics.sumQuantity()?.doubleValue(for: yardUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                print("--Distance\(roundedValue) ydddddddddddd22")
                
                if self.isWorkoutPause == true{
                    self.distance += roundedValue
                    
                }else{
                    self.distance = roundedValue
                }
                
                return
            case HKQuantityType.quantityType(forIdentifier: .stepCount):
                let stepsUnit = HKUnit.count()
                let value = statistics.sumQuantity()?.doubleValue(for: stepsUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                self.steps = roundedValue
                print("DDD--\(self.steps) steps")
                return
                
            case HKQuantityType.quantityType(forIdentifier: .bodyTemperature):
                let bodytempUnit = HKUnit.degreeFahrenheit()
                let value = statistics.sumQuantity()?.doubleValue(for: bodytempUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                self.bodytemp = roundedValue
                print("DDD--\(self.bodytemp) Body Temp")
                return
                
            case HKQuantityType.quantityType(forIdentifier: .vo2Max):
                let vo2Unit = HKUnit(from: "ml/kg*min")
                let value = statistics.sumQuantity()?.doubleValue(for: vo2Unit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                self.vo2 = roundedValue
                print("DDD--\(self.vo2) V02")
                return
                
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning):
                let meterUnit = HKUnit.meter()
                let value = statistics.sumQuantity()?.doubleValue(for: meterUnit)
                let roundedValue = Double( round( 1 * value! ) / 1 )
                self.distanceWalking = roundedValue
                return
                
            default:
                return
            }
        }
    }
}

// MARK: - HKWorkoutSessionDelegate
extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        // Wait for the session to transition states before ending the builder.
        /// - Tag: SaveWorkout
        if toState == .ended {
            print("The workout has now ended.")
            builder!.endCollection(withEnd: Date()) { (success, error) in
                self.builder!.finishWorkout { (workout, error) in
                    // Optionally display a workout summary to the user.
                    if self.isWorkoutPause != true{
                        self.resetWorkout()
                        self.isWorkoutPause = false
                    }
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
}

// MARK: - HKLiveWorkoutBuilderDelegate
extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }
            
            /// - Tag: GetStatistics
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            // Update the published values.
            updateForStatistics(statistics)
        }
    }
}


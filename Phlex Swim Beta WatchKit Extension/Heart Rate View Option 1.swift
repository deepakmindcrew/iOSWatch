//
//  Heart Rate View Option 1.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 1/29/21.
//

import SwiftUI
import HealthKit

struct Heart_Rate_View_Option_1: View {
        private var healthStore = HKHealthStore()
        let heartRateQuantity = HKUnit(from: "count/min")
        
        @State private var value = 0
        
        var body: some View {
            VStack{
                HStack{
                    Text("❤️")
                        .font(.system(size: 50))
                    Spacer()
                }
                
                HStack{
                    Text("\(value)")
                        .fontWeight(.regular)
                        .font(.system(size: 70))
                    
                    Text("BPM").font(.headline)

                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .padding(.bottom, 28.0)
                    
                    Spacer()
                }

            }
            .padding()
            .onAppear(perform: start)
        }

        
        func start() {
            autorizeHealthKit()
            startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        }
        
        func autorizeHealthKit() {
            let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]

            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
        }
        
        private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
            
            // 1
            let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
            // 2
            let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
                query, samples, deletedObjects, queryAnchor, error in
                
                // 3
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
                
            self.process(samples, type: quantityTypeIdentifier)

            }
            
            // 4
            let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
            
            query.updateHandler = updateHandler
            
            // 5
            
            healthStore.execute(query)
        }
        
        private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
            var lastHeartRate = 0.0
            
            for sample in samples {
                if type == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                }
                
                self.value = Int(lastHeartRate)
            }
        }
    }



struct Heart_Rate_View_Option_1_Previews: PreviewProvider {
    static var previews: some View {
        Heart_Rate_View_Option_1()
    }
}

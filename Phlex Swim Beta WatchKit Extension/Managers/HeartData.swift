//
//  HeartData.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 7/3/20.
//

import SwiftUI
import Foundation
import HealthKit


struct HeartRateSample {
    public let heartRate :Double
    public let timestamp : Date
    
    init(_ heartRate : Double, _ timestamp : Date) {
        self.heartRate = heartRate
        self.timestamp = timestamp
    }
}

// Sample rate agnostic heart rate uptick detector
class HeartData : ObservableObject{
    @Published private var heartRates : [HeartRateSample]
    private var deltas : [Double]
    
    init(heartRates: [HeartRateSample] = []) {
        self.heartRates = heartRates
        self.deltas = []
        let start = 1
        let count = self.heartRates.count
        if count > 1 {
            for index in start..<count {
                deltas.append(self.heartRates[index].heartRate - self.heartRates[index - 1].heartRate)
            }
        }
    }
    
    public func getLastHeartRate() -> HeartRateSample? {
        let count = heartRates.count
        if count == 0 {
            return nil
        }
        return heartRates[count - 1]
    }
    
    public func append(heartRate: Double, timestamp: Date) {
        heartRates.append(HeartRateSample(heartRate, timestamp))
    }
}



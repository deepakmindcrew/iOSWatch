//
//  CoreMotion.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
// https://github.com/himbeles/MotionProvider/blob/master/Sources/MotionProvider/MotionProvider.swift


import Foundation
import SwiftUI
import CoreMotion
import CoreData

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    var accelerometerUpdateInterval: Double = 1
    var gyroUpdateInterval: Double = 1
    let queue = OperationQueue()
    var magnetometerUpdateInterval: Double = 1
    @Published var pitch = Double.zero
    @Published var yaw = Double.zero
    @Published var roll = Double.zero
    
    var fx: CGFloat = 0
    var fy: CGFloat = 0
    var fz: CGFloat = 0
    
    var dx: Double = 0
    var dy: Double = 0
    var dz: Double = 0
    
    func startMotionCollection() {
        print("Motion Manager Collection Started")
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
            guard let data = data else {
                print("Error: \(error!)")
                return
            }
            let attitude: CMAttitude = data.attitude
            
            //                    print("pitch: \(attitude.pitch)")
            //                    print("yaw: \(attitude.yaw)")
            //                    print("roll: \(attitude.roll)")
            
            DispatchQueue.main.async {
                self.pitch = attitude.pitch
                self.yaw = attitude.yaw
                self.roll = attitude.roll
            }
        }
    }
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
            guard let gravity = data?.gravity else { return }
            
            self.dx = gravity.x
            self.dy = gravity.y
            self.dz = gravity.z
            
            self.fx = CGFloat(gravity.x)
            self.fy = CGFloat(gravity.y)
            self.fz = CGFloat(gravity.z)
            
            self.objectWillChange.send()
        }
    }
}

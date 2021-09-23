//
//  UnitConversion.swift
//  Phlex Swim Beta
//
//  Created by Ryan Rosenbaum on 7/17/20.
//

import Foundation

func metersToFeet(meters: Double) -> Double {
    return meters * 3.28084
}

func metersPerSecondToMinPerMile(pace: Double) -> Double {
    return (5200 / (pace * 196.82)) > 0 ? (5200 / (pace * 196.82)) : 0
}

func metersPerSecondToMPH(pace: Double) -> Double {
    return pace * 2.23694
}

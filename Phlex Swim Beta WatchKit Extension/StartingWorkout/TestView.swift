//
//  TestView.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Ryan Rosenbaum on 7/20/20.
//

import SwiftUI
import Foundation
import Combine

struct SettingsView: View {
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        Form{
            Section(header: Text("Profile")) {
                    
                Picker(selection: $userSettings.poolSize, label: Text("Default Pool Size")) {
                    ForEach(userSettings.poolSizes, id: \.self) { poolSize in
                        Text(poolSize)
                    }
                }
                HStack {
                        Text("Version")
                        Spacer()
                        Text("0.6")
                    }
                Toggle(isOn: $userSettings.isPrivate) {
                Text("Private Account")
            }
                }
            }
        }
        
    }


struct settingsView_Provider: PreviewProvider{
    static var previews: some View{
        SettingsView()
    }
}


class UserSettings: ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    @Published var isPrivate: Bool {
        didSet {
            UserDefaults.standard.set(isPrivate, forKey: "isAccountPrivate")
        }
    }
    @Published var poolSize: String {
        didSet {
            UserDefaults.standard.set(poolSize, forKey: "poolSize")
        }
    }
    
    public var poolSizes = ["25m", "25yd", "50m", "other"]

    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.isPrivate = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? true
            self.poolSize = UserDefaults.standard.object(forKey: "poolSize") as? String ?? "25m"
           }
       }


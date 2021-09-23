//
//  TimePicker_view.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 15/02/21.
//

import Foundation
import SwiftUI

struct TimePicker_view : View {
    @Binding var showSelf: Bool
    let screenWidth = WKInterfaceDevice.current().screenBounds.size.width - 10
    @State private var selectedMint = 4
    @State private var isPressedDone : Bool = false
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    @State private var isAlert : Bool = false
    
    var body: some View {
        VStack{
            HStack(){
                VStack(spacing: 20) {
                    Picker(selection: $selectedMint, label: Text("")) {
                        ForEach(0..<7) {
                            Text("\($0 * 15) min")
                        }
                    }
                }.onAppear(){
                    selectedMint = (myDelegate.selectedMint)
                }
                .defaultWheelPickerItemHeight(20)
            }.frame(width: 120, height: 100, alignment: .center)
            
            Button("Done", action:  {
                
                if selectedMint == 0{
                    isAlert = true
                }else{
                    myDelegate.selectedMint = (selectedMint)
                    myDelegate.WorkoutTime = "\(selectedMint)"
                    self.showSelf = false
                }
            })
            .font(.system(size : 12, weight : .bold))
            .frame(width: 120, height: 30, alignment: .center)
            .background(Color.green)
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .buttonStyle(PlainButtonStyle())
            .alert(isPresented: $isAlert) {
                Alert(title: Text("Alert"), message: Text("Please select your swiming duration."), dismissButton: .default(Text("OK")))
            }
            
        }
    }
}


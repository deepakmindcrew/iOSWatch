//
//  SmartAnalysis.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//

import SwiftUI

struct SmartAnalysis: View {
    var body: some View {
        VStack {
            Spacer()
            // Main part of view. Percentage Ring view (needs animating), and main stat (needs model)
            ZStack {
                PercentageRing(
                    ringWidth: 14, percent: 60 ,
                    backgroundColor: ColorManager.darker.opacity(0.4),
                    foregroundColors: [Color(#colorLiteral(red: 0.4757325649, green: 0.8559685349, blue: 1, alpha: 1)) ,Color(#colorLiteral(red: 0.5607843137, green: 0.8862745098, blue: 0.9058823529, alpha: 1))]
                )
                MainStat()
                
            }.frame(width: 150, height: 150)
            // Bottom text, a note that should be legible
            VStack{
                Text("Try and get some extra sleep to perform better this week")
                    .font(.system(size: 8, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Spacer()
        }                .padding(.top, 10)
.edgesIgnoringSafeArea(.all).navigationBarHidden(true)
    }
}

struct MainStat: View {
    var body: some View {
        VStack{
            Text("45%")
                .font(.system(size: 45, weight: .light))
                .foregroundColor(.yellow)
            
            Text("Recovery")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.white)
        }
    }
}

struct SmartAnalysis_Previews: PreviewProvider {
    static var previews: some View {
        SmartAnalysis()
    }
}

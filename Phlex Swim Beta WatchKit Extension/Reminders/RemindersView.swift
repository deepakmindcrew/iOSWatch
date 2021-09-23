//
//  RemindersView.swift
//  phlexswimwatch Extension
//
//  Created by Ryan Rosenbaum on 6/23/20.
//

import SwiftUI

struct RemindersView: View {
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            VStack{
                Text("Days Until!")
                    .fontWeight(.regular)
                Text("Olympic Trials")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(ColorManager.lightBlue)
            }
            VStack{
                Text("137")
                    .font(.system(size: 60, weight: .medium))
                Image(systemName: "bell.circle.fill")
                    .font(.system(size: 50))
                    .offset(y: -20)
                    .foregroundColor(ColorManager.lightBlue)
            }
            Spacer()
        }                .padding(.top, 10)
        .edgesIgnoringSafeArea(.all).navigationBarHidden(true)
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

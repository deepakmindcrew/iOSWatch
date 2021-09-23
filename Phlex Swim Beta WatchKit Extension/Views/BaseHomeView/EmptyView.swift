//
//  EmptyView.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 24/02/21.
//

import Foundation
import SwiftUI

struct EmptyView : View {
    @Binding var resetView:String
    
    var body: some View{
        VStack{
            Text(resetView)
                .font(.system(size: 17, weight : .bold))
                .multilineTextAlignment(.center)
        }.navigationBarHidden(false)
    }
}

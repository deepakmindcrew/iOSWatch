//
//  BarWithLabel.swift
//  Bar Chart
//
//  Created by Mazharul Huq on 6/30/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import SwiftUI

struct BarWithLabel : View {
    let month:String
    let rainfall:CGFloat
    let isEmpty :Bool
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(ColorManager.lightBlue)
                .opacity(isEmpty ? 1.0 : 0.4)
                
                .frame(width:15.0,height:10*self.rainfall)
            Text(self.month).font(.system(size: 7))
        }
    }    
}



//
//  DashboardView.swift
//  Phlex Swim Beta
//
//  Created by Ryan Rosenbaum on 1/28/21.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        ZStack {
            mainBackground()
            
            VStack {
                userProfileHeader()
                    .padding(.vertical)
                RecentWorkoutView()
                    .padding(.vertical)
                    .shadow(color: .black, radius: 5)
                
                trendsView()
                    .padding(.vertical)
                    .shadow(color: .black, radius: 5)
            }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}

struct userProfileHeader: View {
    var body: some View {
        HStack{
            Image("MarcinLandingPage3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: .leading)
                .clipShape(
                    Circle())
            
            VStack(alignment: .leading){
                
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                
                Text("Marcin")
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
            }
            
            Spacer()
            
            Image(systemName: "bell.badge")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            
        }.padding(.horizontal)
    }
}

struct mainBackground: View {
    var body: some View {
        ZStack(alignment: .topTrailing, content: {
            
            LinearGradient(gradient: .init(colors: [Color("Color1"), Color("Color-4")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            Image("topBg")
            
        }).edgesIgnoringSafeArea(.all)
    }
}


struct SplashScore: View {
    var splashScore: String = "95"
    var caloriesBurned: String = "95"
    
    var body: some View {
        HStack {
            VStack{
                Text(splashScore).font(.system(size: 24, weight: .medium, design: .rounded)).foregroundColor(.black)
                Text("Splash Score").foregroundColor(.gray).font(.system(size: 12, weight: .medium, design: .rounded))
            }
            Image("diamond").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .center)
            VStack{
                Text(caloriesBurned).font(.system(size: 24, weight: .medium, design: .rounded)).foregroundColor(.black)
                Text("Calories Burned").foregroundColor(.gray).font(.system(size: 12, weight: .medium, design: .rounded))
            }
            
        }
    }
}

struct RecentWorkoutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Workout").foregroundColor(.white).font(.system(size: 16, weight: .semibold, design: .rounded))
                .padding(.horizontal)
            VStack(alignment: .center, spacing: 30){
                HStack(alignment: .center, spacing: 30){
                    VStack{
                        Text("95")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                        Text("Splash Score")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                    Image("diamond").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .center)
                    VStack{
                        Text("316 KCAL")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                        Text("Calories")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                }.padding(.horizontal)
                
                HStack(alignment: .center, spacing: 40){
                    VStack{
                        Text("1750 M")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                        Text("Distance")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                    Image("swimNow").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .center)
                    VStack{
                        Text("27 Mins")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                        Text("Time")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                }.padding(.horizontal)
                
                HStack(alignment: .center, spacing: 40){
                    VStack{
                        Text("129 BPM")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                        Text("Avg. HR")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                    Image("heart-1").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
                    VStack{
                        Text("162 BPM")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                        Text("Max HR")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }
                }.padding(.horizontal)
            }.padding().padding(.horizontal).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}



struct trendsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Workout").foregroundColor(.white).font(.system(size: 16, weight: .semibold, design: .rounded))
                .padding(.horizontal)
            HStack {
                
                HStack{
                    Image("Heart-1)")
                    Text("162")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("bpm")
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                }.padding()
                .padding(.horizontal)
                .frame(height: 200)
                .background(Color(#colorLiteral(red: 0.05671179295, green: 0.1092290655, blue: 0.5996066332, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                
                VStack(alignment: .center, spacing: 20){
                    HStack(alignment: .center, spacing: 30){
                        VStack{
                            Text("95")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                            Text("Splash Score")
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                    }.padding()
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    
                    HStack(alignment: .center, spacing: 30){
                        VStack{
                            Text("95")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                            Text("Splash Score")
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                    }.padding()
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
            }
        }
    }
}

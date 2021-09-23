//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Ryan Rosenbaum on 1/20/21.
//  Copyright © 2021 Duy Bui. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        ScrollView {
            
            Spacer()
            VStack{
                HeaderView().padding(.horizontal)
                
                ScrollView {
                    ZStack {
                        PowerUsageView()
                            .background(RoundedRectangle(cornerRadius: 50.0).foregroundColor(.white).opacity(0.2))
                    }.offset(y: 35)
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Swimmer Highlights").font(.system(size: 22, weight: .semibold, design: .rounded))
                            Spacer()
                        }.padding(.leading, 20)
                        .padding(.top)
                        Categories().padding(.leading, 25)
                        
                        VStack {
                            HStack {
                                Text("Uploads").font(.system(size: 24, weight: .bold, design: .rounded))
                                Spacer()
                            }
                            
                            HStack(spacing: 20){
                                Image("1") .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .clipped()  // Equal to clipsToBounds = true
                                    .cornerRadius(10)
                                Image("2").resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .clipped()  // Equal to clipsToBounds = true
                                    .cornerRadius(10)
                                Image("3").resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .clipped()  // Equal to clipsToBounds = true
                                    .cornerRadius(10)
                                Image("t").resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .clipped()  // Equal to clipsToBounds = true
                                    .cornerRadius(10)
                            }
                            
                        }.padding()
                        Color(.white).frame(height: 100, alignment: .center)
                        
                    }.padding().background(RoundedRectangle(cornerRadius: 50).foregroundColor(.white))
                    
                    
                    
                    
                    
                }
            }
        }.offset(y: 50).background( ZStack(alignment: .topTrailing, content: {
            
            LinearGradient(gradient: .init(colors: [Color("Color1"), Color("Color-4")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            Image("topBg")
            
        })
        
        )    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct Categories: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 50) {
                VStack(alignment: .center) {
                    Text("Day")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.black)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 20, height: 6)
                        .foregroundColor(Color.blue)                    .padding(.top, -3)
                }
                VStack(alignment: .center) {
                    Text("Week")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color.black)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 60, height: 6)
                        .foregroundColor(Color.blue)
                        .opacity(0)
                        .padding(.top, -3)
                }
                VStack(alignment: .center) {
                    Text("Month")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color.black)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 60, height: 6)
                        .foregroundColor(Color.orange)
                        .opacity(0)
                        .padding(.top, -3)
                }
                VStack(alignment: .center) {
                    Text("Season")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color.black)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 60, height: 6)
                        .foregroundColor(Color.orange)
                        .opacity(0)
                        .padding(.top, -3)
                }
                
            }
        }
    }
}


//MARK: HeaderView
struct HeaderView: View {
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(systemName: "square.and.arrow.up").font(.system(size: 22, weight: .bold)).foregroundColor(.white).padding()
                Spacer()
                
                VStack {
                    
                    Image("t")
                        .resizable()
                        
                        .clipShape(Circle())
                        .frame(width: 80, height: 80, alignment: .center)
                    VStack(alignment: .center) {
                        Text("Ryan Rosenbaum")
                            .font(.system(size: 26, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Text("Swim Fort Lauderdale Aquatics")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.white).opacity(0.8)
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Follow")
                        
                    })
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .padding(.leading, 30)
                    .padding(.top, 10)
                    .padding(.trailing, 30)
                    .padding(.bottom, 10)
                    .background(Color(#colorLiteral(red: 0.2117647059, green: 0.6078431373, blue: 1, alpha: 1)))
                    .cornerRadius(25)
                    
                }
                Spacer()
                
                Image(systemName: "gear").font(.system(size: 22, weight: .bold)).foregroundColor(.white).padding()
            }
        }
    }
}

//MARK: PowerUsageView
struct PowerUsageView: View {
    var body: some View {
        
        
        VStack {
            HStack {
                HStack(spacing: 60) {
                    
                    VStack(alignment: .leading) {
                        Text("108")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Text("Followers")
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(.white).opacity(0.7)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("108")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Text("Following")
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(.white).opacity(0.7)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("427")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Text("Total Uploads")
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(.white).opacity(0.7)
                    }
                }
            }.padding()
            .offset(y: -15)
        }.frame(width: 400, height: 100)
        
    }
}


struct ProfileViewSocialoPTION: View {
    @State var selected = 0
    let data: [DataModel] = [
        .init(id: "0", imageName: "Collection"),
        .init(id: "1", imageName: "Collection2"),
        .init(id: "2", imageName: "Collection"),
        .init(id: "3", imageName: "Collection2")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15.0) {
                Text("@ifgs1")
                    .font(.custom("HelveticaNeue-Medium", size: 16.0))
                Image("ProfilePicture")
                Text("Ivan Garcia")
                    .font(.custom("HelveticaNeue-Medium", size: 20.0))
                Text("Photography lover from 8 years ")
                    .font(.custom("HelveticaNeue-Regular", size: 14.0))
                    .foregroundColor(Color("LightGrayColor"))
                
                SegmentedControlView(selected: self.$selected, segments: [Segment(id: 0, segmentName: "Photos"), Segment(id: 1, segmentName: "Likes"), Segment(id: 2, segmentName: "Marks")])
                List {
                    ForEach(data) { items in
                        CollectionView(data: items)
                    }
                }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }
        }.background(Color(.white).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("")
        .navigationBarItems(trailing: Button(action : {
            
        }){
            Image("Menu").foregroundColor(.gray)
        })
    }
}

struct DataModel: Identifiable {
    let id: String
    let imageName: String
}

struct CollectionView: View {
    let data: DataModel
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<2) { items in
                    Spacer()
                    Image(self.data.imageName)
                    Spacer()
                }
            }
        }
    }
}

// DashBoard Grid Model Data...

struct Fitness : Identifiable {
    
    var id : Int
    var title : String
    var image : String
    var data: String
    var suggest : String
}
var week_Fit_Data = [
    
    Fitness(id: 0, title: "Avg Heart Rate", image: "heart", data: "163 bpm", suggest: "80-120\nHealthy"),
    
    Fitness(id: 1, title: "Sleep", image: "sleep", data: "43h 23m", suggest: "Deep Sleep\n26h 13m"),
    
    Fitness(id: 2, title: "Swim Calories", image: "energy", data: "1,275 kcal", suggest: "Weekly Goal\n4,800 kcal"),
    
    Fitness(id: 3, title: "Laps", image: "steps", data: "373", suggest: "Weekly Goal\n25,0000 Steps"),
    
    Fitness(id: 4, title: "Primary Stroke", image: "running", data: "Butterfly", suggest: "Weekly Goal\n70 km"),
    
    Fitness(id: 5, title: "Splash Score", image: "cycle", data: "398", suggest: "Weekly Goal\n125 km"),
    Fitness(id: 6, title: "Steps", image: "steps", data: "17,8741", suggest: "Weekly Goal\n25,0000 Steps"),
    
    Fitness(id: 7, title: "Running", image: "running", data: "45.3 km", suggest: "Weekly Goal\n70 km"),
    
    Fitness(id: 8, title: "Cycling", image: "cycle", data: "100.3 km", suggest: "Weekly Goal\n125 km"),
]


@available(iOS 14.0, *)
struct GridView2 : View {
    
    var fitness_Data : [Fitness]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View{
        
        LazyVGrid(columns: columns,spacing: 30){
            
            ForEach(fitness_Data){fitness in
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text(fitness.title)
                            .foregroundColor(.white)
                        
                        Text(fitness.data)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top,20)
                        
                        HStack{
                            
                            Spacer(minLength: 0)
                            
                            Text(fitness.suggest)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    // image name same as color name....
                    .background(Color(fitness.image))
                    .cornerRadius(20)
                    // shadow....
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    
                    // top Image....
                    
                    Image(fitness.image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal)
        .padding(.top,25)
        
    }
}

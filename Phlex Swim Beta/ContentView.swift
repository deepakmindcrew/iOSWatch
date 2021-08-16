//
//  ContentView.swift
//  Phlex Swim Beta
//
//  Created by Ryan Rosenbaum on 7/16/20.
//
import SwiftUI
@available(iOS 14.0, *)
struct ContentView: View {
        @StateObject var viewRouter: ViewRouter
        
        @State var showPopUp = false
        
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    switch viewRouter.currentPage {
                    case .home:
                        Dashboard().edgesIgnoringSafeArea(.all)
                    case .liked:
                        AirlineBookingApp().edgesIgnoringSafeArea(.all)
                    case .records:
                       Workout_and_Calendar_View()
                    case .user:
                        ProfileView().edgesIgnoringSafeArea(.all)
                    }
                    Spacer()
                    ZStack {
                        if showPopUp {
                            PlusMenu(widthAndHeight: geometry.size.width/7)
                                .offset(y: -geometry.size.height/6)
                        }
                        HStack {
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Dashboard")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .liked, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "gamecontroller", tabName: "Games")
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                    .shadow(radius: 4)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    .foregroundColor(Color("Color1"))
                                    .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                            }
                                .offset(y: -geometry.size.height/8/2)
                                .onTapGesture {
                                    withAnimation {
                                        showPopUp.toggle()
                                    }
                                }
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .records, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "waveform", tabName: "Workouts")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile")
                        }
                            .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }

@available(iOS 14.0, *)
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(viewRouter: ViewRouter())
                .preferredColorScheme(.light)
        }
    }

    struct PlusMenu: View {
        
        let widthAndHeight: CGFloat
        
        var body: some View {
            HStack(spacing: 50) {
                ZStack {
                    Circle()
                        .foregroundColor(Color("Color-4"))
                        .frame(width: widthAndHeight, height: widthAndHeight)
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .foregroundColor(Color("Color-4"))
                        .frame(width: widthAndHeight, height: widthAndHeight)
                    Image(systemName: "applewatch")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.white)
                }
            }
                .transition(.scale)
        }
    }

@available(iOS 14.0, *)
struct TabBarIcon: View {
        
        @StateObject var viewRouter: ViewRouter
        let assignedPage: Page
        
        let width, height: CGFloat
        let systemIconName, tabName: String

        var body: some View {
            VStack {
                Image(systemName: systemIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                Text(tabName)
                    .font(.footnote)
                Spacer()
            }
                .padding(.horizontal, -4)
                .onTapGesture {
                    viewRouter.currentPage = assignedPage
                }
                .foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
        }
    }



@available(iOS 14.0, *)
struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

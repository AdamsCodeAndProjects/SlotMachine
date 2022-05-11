//
//  ContentView.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            // -----------------------Background-------------------------------
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // ------------------------Interface--------------------------------
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                
                Spacer()
                
                // --------------------Score------------------------------
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle() // extension with added styling
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            .scoreNumberStyle() // Another extension
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("200")
                            .scoreNumberStyle() // Another extension
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle() // extension with added styling
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                VStack(alignment: .center, spacing: 0) {
                    ZStack {
                        ReelView()
                        Image("bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image("seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ReelView()
                            Image("cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    
                    Button(action: {
                        print("spin")
                    }) {
                        Image("spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                
                Spacer()
            }
            //-----------------------Top Buttons--------------------------------
            .overlay(
                Button(action: {
                    print("Reset the game")
                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .font(.title)
                    .accentColor(Color.white), alignment: .topLeading
            )
            .overlay(
                Button(action: {
                    print("Info View")
                }) {
                    Image(systemName: "info.circle")
                }
                    .font(.title)
                    .accentColor(Color.white), alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

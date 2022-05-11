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
            // --------------------Background-------------------------------
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // --------------------Interface--------------------------------
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                
                Spacer()
            }
            //----------------------Buttons------------------------------
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

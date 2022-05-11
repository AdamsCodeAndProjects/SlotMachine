//
//  SlotView.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import SwiftUI

struct SlotView: View {
    var body: some View {
        ZStack {
                Image("background")
                    .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Image("slot-machine")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300.0, height: 200.0)
                        .padding()
                

            }
                
        }
    }
}

struct SlotView_Previews: PreviewProvider {
    static var previews: some View {
        SlotView()
    }
}

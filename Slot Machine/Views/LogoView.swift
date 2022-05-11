//
//  LogoView.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("slot-machine")
            .resizable()
            .scaledToFit().frame(minWidth: 256, idealWidth: 300, maxWidth: 320, minHeight: 112, idealHeight: 130, maxHeight: 140, alignment: .center)
            .padding(.horizontal)
//                    .layoutPriority(1)
            .modifier(ShadowModifier()) // From modifier page - Adds shadow
            
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}

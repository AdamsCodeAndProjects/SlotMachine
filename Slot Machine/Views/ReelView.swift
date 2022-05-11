//
//  ReelView.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
            .previewLayout(.fixed(width: 220, height: 220))
    }
}

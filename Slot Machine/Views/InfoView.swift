//
//  InfoView.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode // allows us to close out the sheet when clicked
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section(header: Text("About the application")) {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "IPhone, IPad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "John / Jane")
                    FormRowView(firstItem: "Designer", secondItem: "Adam Januszewski")
                    FormRowView(firstItem: "Music", secondItem: "Twisted Sister")
                    FormRowView(firstItem: "Website", secondItem: "nowhere.com")
                    FormRowView(firstItem: "Copyright", secondItem: "© 2022 All rights reserved")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
            Button(action: {
                //  Dismiss the sheet
                self.presentationMode.wrappedValue.dismiss()
            }) {
            Image(systemName: "xmark.circle")
                    .font(.title)
            }
                .padding(.top, 30)
                .padding(.trailing, 20)
                .accentColor(Color.secondary)
            , alignment: .topTrailing
        )
    }
}

struct FormRowView: View {
    
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack {
            Text(firstItem).foregroundColor(Color.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}



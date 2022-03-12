//
//  ContentView.swift
//  Worthless
//
//  Created by Yauheni Shauchenka on 2/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var inAppsManager: InAppsManager
    
    var body: some View {
            
            NavigationView {
                VStack {
                    Text("Итак, ты решил отдать автору этого приложения часть своих кровно заработанных денег, что дальше?")
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    
                    NavigationLink(destination: payMe(inAppsManager: inAppsManager)) {
                        Text("Просто заткнись и возьми мои деньги")
                    }
//                    inAppsManager.myProducts
                    
                    Text("или")
                        .multilineTextAlignment(.center)
                        .padding()
                    NavigationLink(destination: MailMe()) {
                        Text("Может сначала поговорим?")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(inAppsManager: InAppsManager())
    }
}

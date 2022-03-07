//
//  WorthlessApp.swift
//  Worthless
//
//  Created by Yauheni Shauchenka on 2/9/21.
//

import SwiftUI
import StoreKit

@main
struct WorthlessApp: App {
    
    let productIDs = [
          "5usdworthless",
          "5usd_subsc_worthless",
          "5usd_whale_worthless"
      ]
    
    @StateObject var inAppsManager = InAppsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(inAppsManager: inAppsManager)
                .onAppear(perform: {
                    SKPaymentQueue.default().add(inAppsManager)
                    inAppsManager.getProducts(productIDs: productIDs)
            })
        }
    }
}

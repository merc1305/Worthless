//
//  whalePayers.swift
//  Worthless
//
//  Created by Yauheni Shauchenka on 3/7/22.
//

import SwiftUI

struct whalePayers: View {
    
    @StateObject var inAppsManager: InAppsManager
    
    var body: some View {
        
//        NavigationView {
            VStack {
                Text("🐋")
                    .font(.system(size: 140))
                    .padding(.top, -70.0)
                
                Spacer()
                
                Text("Киты - это такие пользователи, которые платят сильно больше среднего чека. В основном они это делают просто потому, что могут. \n\nДля справки: максимальный разрешенный платеж на сегодня через Apple - это 1000-1200 usd в зависимости от региона пользователя, причем разработчик получит максимум 850 usd")
                    .multilineTextAlignment(.leading)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                    
                
                List(inAppsManager.myWhaleProducts, id: \.self) { product in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.localizedTitle)
                                .font(.headline)
                            Text(product.localizedDescription)
                                .font(.caption2)
                        }
                        Spacer()
                        if UserDefaults.standard.bool(forKey: product.productIdentifier) {
                            Text ("Куплено!")
                                .foregroundColor(.green)
                        } else {
                            Button(action: {
                                inAppsManager.purchaseProduct(product: product)
                            }) {
                                Text("Купить за \(product.price) $")
                            }
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Spacer()
                    
                NavigationLink(destination: MailMe()) {
                    Text("Пожалуй я хочу узнать побольше \n перед покупкой.  Может \n сначала поговорим?")
                        .multilineTextAlignment(.center)
                }
//                Spacer()
            }
        }
//    }
}

struct whalePayers_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            whalePayers(inAppsManager: InAppsManager())
        }
    }
}

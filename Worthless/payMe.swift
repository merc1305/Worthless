//
//  payMe.swift
//  Worthless
//
//  Created by Yauheni Shauchenka on 3/7/22.
//

import SwiftUI

struct payMe: View {
    
    @StateObject var inAppsManager: InAppsManager
        
    var body: some View {
//        NavigationView {
            VStack {
                Text("Без проблем, просто выбери разово хочешь дать денег или подписаться на еженедельные списания:")
                    .multilineTextAlignment(.leading)
                    .padding()
//                Button("Плачу разово 5 usd") {
//                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//                }
//
//                Text("-")
//                    .multilineTextAlignment(.center)
//                    .padding()
//
//                if UserDefaults.standard.bool(forKey: "*ID of IAP Product*") {
//                        Text("Я уже плачу Жене 5 usd в неделю")
//                            .foregroundColor(.green)
//                    } else {
//                        Button("Плачу 5 usd в неделю") {
//                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//                            }
//                    }
                
                List(inAppsManager.myProducts, id: \.self) { product in
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
                
                NavigationLink(destination: whalePayers(inAppsManager: inAppsManager)) {
                    Text("А кто такой Кит🐋?")
                        .font(.system(size: 30))
                    
                }
                Spacer()
                
            }
        }
//    }
}

struct payMe_Previews: PreviewProvider {
    static var previews: some View {
        payMe(inAppsManager: InAppsManager())
    }
}

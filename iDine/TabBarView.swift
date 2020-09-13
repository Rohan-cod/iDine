//
//  TabBarView.swift
//  iDine
//
//  Created by pamarori mac on 12/09/20.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            
            OrderView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
                }
            
            MyOrders()
                .tabItem {
                    Image(systemName: "clock")
                    Text("My Orders")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

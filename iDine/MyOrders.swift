//
//  MyOrders.swift
//  iDine
//
//  Created by pamarori mac on 13/09/20.
//

import SwiftUI
import Firebase

struct MyOrders: View {
    
    @State private var orders = [Myorder]()
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    MyOrdersCell(order: order)
                }
            }
            .navigationBarTitle("My Orders")
        }.onAppear {
            fetchOrders()
        }
    }
    
    func fetchOrders() {
        guard let currentuid = Auth.auth().currentUser?.uid else { return }
        ORDERS_REF.child(currentuid).observe(.childAdded) { (snapshot) in
            
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            var items = [Item]()
            
            ORDERS_REF.child(currentuid).child(snapshot.key).child("items").observe(.value) { (itemsnapshot) in
                guard let itemdictionary = itemsnapshot.value as? Dictionary<String, AnyObject> else { return }
                for (key, val) in itemdictionary {
                    guard let name = val["name"] as? String else { return }
                    guard let price = val["price"] as? Int else { return }
                    items.append(Item(id: UUID(), name: name, price: price))
                }
                
            }
            guard let total = dictionary["total"] as? Int else { return }
            guard let numberOfItems = dictionary["numberOfItems"] as? Int else { return }
            guard let date = dictionary["date"] as? Int else { return }
            
            let order = Myorder(id: UUID(), total: total, numberOfItems: numberOfItems, date: date, items: items)
            self.orders.append(order)
            
            
        }
        
    }
}

struct MyOrders_Previews: PreviewProvider {
    static var previews: some View {
        MyOrders()
    }
}


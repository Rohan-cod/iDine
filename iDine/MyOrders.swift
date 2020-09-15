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
        ORDERS_REF.child(currentuid).observeSingleEvent(of: .childAdded) { (snapshot) in
            
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { print("dictionary"); return }
            guard let total = dictionary["total"] as? Double else { print("total"); return }
            guard let numberOfItems = dictionary["numberOfItems"] as? Int else { print("numberofitems"); return }
            guard let date = dictionary["date"] as? Int else { print("date"); return }
            guard let items = dictionary["items"] as? Dictionary<String, AnyObject> else { print("items"); return }
            var order = Myorder(id: UUID(), total: total, numberOfItems: numberOfItems, date: date, items: [Item]())
            for (key, val) in items {
                
                guard let valdictionary = val as? Dictionary<String, AnyObject> else { print("valdictionary"); return }
                guard let name = valdictionary["name"] as? String else { print("name"); return }
                guard let price = valdictionary["price"] as? Int else { print("price"); return }
                guard let quantity = valdictionary["quantity"] as? Int else { print("quantity"); return }
                order.items.append(Item(id: UUID(), name: name, price: price, quantity: quantity))
                
            }
            
            self.orders.append(order)
        }
    }
}

struct MyOrders_Previews: PreviewProvider {
    static var previews: some View {
        MyOrders()
    }
}


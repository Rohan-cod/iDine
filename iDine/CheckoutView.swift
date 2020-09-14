//
//  CheckoutView.swift
//  iDine
//
//  Created by pamarori mac on 07/09/20.
//

import SwiftUI
import Firebase

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add iDine loyalty card")
                }
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header:
                        Text("TOTAL: $\(totalPrice, specifier: "%.2f")")
                        .font(.largeTitle)
            ) {
                Button("Confirm order") {
                    self.showingPaymentAlert.toggle()
                    // Add order to database
                    guard let currentuid = Auth.auth().currentUser?.uid else { return }
                    let total = order.total
                    let date = Int(NSDate().timeIntervalSince1970)
                    let numberOfItems = order.items.count
                    let values = ["total": total,
                              "date": date,
                              "numberOfItems": numberOfItems
                    ] as [String : Any]
                    let orderid = ORDERS_REF.child(currentuid).childByAutoId()
                    orderid.setValue(values)
                    for item in order.items {
                        let name = item.name
                        let price = item.price
                        let val = [
                            "name": name,
                            "price": price
                        ] as [String : Any]
                        orderid.child("items").childByAutoId().setValue(val)
                    }
                    
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%.2f") – thank you!"), dismissButton: .default(Text("OK"), action: { order.removeall(); ContentView() }))
            
        }
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}

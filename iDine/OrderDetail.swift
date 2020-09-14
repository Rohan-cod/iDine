//
//  OrderDetail.swift
//  iDine
//
//  Created by pamarori mac on 14/09/20.
//

import SwiftUI

struct OrderDetail: View {
    
    let order: Myorder
    
    
    var body: some View {
        
        List {
            ForEach(order.items) { item in
                
                HStack {
                    Image("\(item.name.lowercased().withReplacedCharacters(" ", by: "-"))-thumb")
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                    }
                    Spacer()
                    Text(String("$\(item.price)"))
                    
                }
                
            }
        }
        
    }
    
}



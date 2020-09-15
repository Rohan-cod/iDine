//
//  Item.swift
//  iDine
//
//  Created by pamarori mac on 14/09/20.
//

import Foundation


struct Item: Identifiable {
    
    var id = UUID()
    var name: String
    var price: Int
    var quantity: Int
    
}

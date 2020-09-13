//
//  Myorder.swift
//  iDine
//
//  Created by pamarori mac on 13/09/20.
//

import Foundation


struct Myorder: Identifiable {
    
    var id = UUID()
    var total: Int
    var numberOfItems: Int
    var date: Int
    var items: [Item]
    
}

struct Item: Identifiable {
    
    var id = UUID()
    var name: String
    var price: Int
}

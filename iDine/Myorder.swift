//
//  Myorder.swift
//  iDine
//
//  Created by pamarori mac on 13/09/20.
//

import Foundation


struct Myorder: Identifiable {
    
    var id = UUID()
    var total: Double
    var numberOfItems: Int
    var date: Int
    var items: [Item]
    
}

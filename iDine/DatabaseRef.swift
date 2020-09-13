//
//  DatabaseRef.swift
//  iDine
//
//  Created by pamarori mac on 13/09/20.
//

import Foundation
import Firebase
import FirebaseDatabase

var ref: DatabaseReference! = Database.database().reference()

var ORDERS_REF = ref.child("orders")

//
//  MyOrdersCell.swift
//  iDine
//
//  Created by pamarori mac on 13/09/20.
//

import SwiftUI

struct MyOrdersCell: View {
    
    let order: Myorder
    
    var body: some View {
        VStack {
            Text("Total: \(order.total)$")
                .font(.title)
                .fontWeight(.bold)
            Text("\(order.numberOfItems) Items")
                .font(.title)
                .fontWeight(.bold)
            ForEach(order.items) { item in
                
                VStack {
                    Text("Name: \(item.name)")
                    Text("Price: \(item.price)$")
                }
                
                
            }
            Text(timeAgoToDisplay(order.date))
                .foregroundColor(.gray)
        }
    }
    
    func timeAgoToDisplay(_ time: Int) -> String {
        let secondsAgo = Int(time)
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "SECOND"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "MIN"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "HOUR"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "DAY"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "WEEK"
        } else {
            quotient = secondsAgo / month
            unit = "MONTH"
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "S") AGO"
    }
}



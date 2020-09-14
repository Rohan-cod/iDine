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
        
        NavigationLink(destination: OrderDetail(order: order)) {
            HStack {
                
                VStack {
                    Text("Total: \(order.total)$")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Number of Items: \(order.numberOfItems)")
                        .fontWeight(.bold)
                    
                        
                }
                .font(.title3)
                
                Spacer()
                
                Text(timeAgoToDisplay(order.date))
                    .foregroundColor(.gray)
            }
        }
    }
    
    func timeAgoToDisplay(_ time: Int) -> String {
        let secondsAgo = Int(NSDate().timeIntervalSince1970) - Int(time)
        
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



//
//  ItemRow.swift
//  iDine
//
//  Created by pamarori mac on 07/09/20.
//

import SwiftUI

struct ItemRow: View {
    
    var item: MenuItem
    @State var stepperValue: Int = 5000
    @EnvironmentObject var order: Order
    static let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    
    var body: some View {
        NavigationLink(destination: ItemDetail(item: item)) {
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    
                    HStack {
                        Text(String("$\(item.price)"))
                        ForEach(item.restrictions, id: \.self) { restriction in
                            Text(restriction)
                                .font(.caption)
                                .fontWeight(.black)
                                .padding(5)
                                .background(Self.colors[restriction, default: .black])
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
                Stepper("",
                        onIncrement: {
                            self.order.add(item: self.item)
                        },
                        onDecrement: {
                            self.order.remove(item: self.item)
                        })
                
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}

//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Caique Ferraz on 16/08/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.user.name)
                TextField("Street Address", text: $order.user.streetAddress)
                TextField("City", text: $order.user.city)
                TextField("Zip", text: $order.user.zip)
            }
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order) 
                }
            }
            .disabled(order.user.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}

//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Caique Ferraz on 19/08/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "BRL"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error", isPresented: $showingAlert) {
            
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            errorAlert("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order of \(decodedOrder.quantity) \(Order.types[decodedOrder.type]) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            errorAlert("Check out failed: \(error.localizedDescription)")
        }
    }
    
    func errorAlert(_ message: String) {
        alertMessage = message
        showingAlert = true
    }
}

#Preview {
    CheckoutView(order: Order())
}

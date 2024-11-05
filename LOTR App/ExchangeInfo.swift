//
//  ExcahngeInfo.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 01/11/2024.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            //background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                //title
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                
                //description
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title2)
                    .padding()
                
                // exchange rate
                ExchangeRateView(
                    leftImage: .goldpiece ,
                    exchangeRate: "1 Gold Piece = 4 Gold Pennies",
                    rightImage: .goldpenny
                )
                ExchangeRateView(
                    leftImage: .goldpenny ,
                    exchangeRate: "1 Gold Penny = 4 Silver Pennies",
                    rightImage: .silverpiece
                )
                ExchangeRateView(
                    leftImage: .silverpiece ,
                    exchangeRate: "1 Silver Piece = 4 Gold Pennies",
                    rightImage: .silverpenny
                )
                ExchangeRateView(
                    leftImage: .silverpenny ,
                    exchangeRate: "1 Silver Penny = 100 Copper Pennies",
                    rightImage: .copperpenny
                )
                
                // done button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.title)
                .padding()
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}


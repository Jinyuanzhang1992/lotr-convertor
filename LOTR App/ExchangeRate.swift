//
//  ExchangeRate.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 01/11/2024.
//

import SwiftUI

struct ExchangeRateView: View {
    let leftImage:ImageResource
    let exchangeRate:String
    let rightImage:ImageResource
    
    var body: some View {
        HStack {
            // left currency image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height:33)
            // exchange rate text
            Text(exchangeRate)
            // right current image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}


#Preview{
    ExchangeRateView(
        leftImage: .goldpiece , exchangeRate: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny
    )
}

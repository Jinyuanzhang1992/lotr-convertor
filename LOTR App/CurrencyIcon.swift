//
//  CurrencyIcon.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 01/11/2024.
//

import SwiftUI

struct CurrencyIcon: View {
    let currencyImage:ImageResource
    let currencyName:String
    
    var body: some View {
        //Currency icons
        ZStack(alignment: .bottom) {
            //currency image
            Image(currencyImage)
                .resizable()
                .scaledToFit()

            // currency name
            Text(currencyName)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
                .foregroundStyle(.black)
        }
        .padding(3)
        .frame(width: 100, height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    CurrencyIcon(currencyImage: .goldpenny, currencyName: "Gold Penny")
}

//
//  IconGrid.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 01/11/2024.
//

import SwiftUI

struct IconGrid: View {
    @Binding var selectedCurrency:Currency
    
    var body: some View {
        LazyVGrid(columns:[GridItem(),GridItem(),GridItem()]) {
            ForEach(Currency.allCases, id: \.self) {item in
                if item == selectedCurrency {
                    CurrencyIcon(
                        currencyImage: item.image,
                        currencyName: item.name
                    )
                    .shadow(color: .black, radius: 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3)
                            .opacity(0.5)
                    }
                } else {
                    CurrencyIcon(
                        currencyImage: item.image,
                        currencyName: item.name
                    )
                    .onTapGesture {
                        selectedCurrency = item
                    }
                }
            }
        }
    }
}

#Preview {
    IconGrid(selectedCurrency: .constant(.silverPiece))
}

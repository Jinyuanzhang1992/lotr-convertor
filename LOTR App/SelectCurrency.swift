//
//  SelectCurrency.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 01/11/2024.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency:Currency
    @Binding var bottomCurrency:Currency

    var body: some View {
        ZStack {
            //background
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                //Text
                Text(
                    "Select the currency you are starting with:"
                )
                    .fontWeight(.bold)
                    .foregroundStyle(.black) 
                
                //Currency icons
                IconGrid(selectedCurrency: $topCurrency)
       
                //text
                Text("Select the currency you would like convert to:")
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top,30)
                
                //currency icons
                IconGrid(selectedCurrency: $bottomCurrency)
                
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
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(
        topCurrency: .constant(.goldPenny),
        bottomCurrency: .constant(.silverPenny)
    )
}

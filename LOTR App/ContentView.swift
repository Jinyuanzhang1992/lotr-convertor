//
//  ContentView.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 31/10/2024.
//

import SwiftUI
import TipKit

// 首先定义 UserDefaults 的键
extension UserDefaults {
    static let leftCurrencyKey = "leftCurrency"
    static let rightCurrencyKey = "rightCurrency"
}

// 为 Currency 添加 RawValue 支持，这样可以存储在 UserDefaults 中
extension Currency: RawRepresentable {
    // 使用货币名称作为原始值
    public var rawValue: String {
        return self.name
    }
    
    // 从原始值创建货币类型
    public init?(rawValue: String) {
        switch rawValue {
        case "Copper Penny": self = .copperPenny
        case "Silver Penny": self = .silverPenny
        case "Silver Piece": self = .silverPiece
        case "Gold Penny": self = .goldPenny
        case "Gold Piece": self = .goldPiece
        default: return nil
        }
    }
}

struct ContentView: View {
    @State private var showInfo = false
    @State var showSelectedCurrency = false
    
    @State private var leftAmount = ""
    @State private var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
//    @State var leftCurrency: Currency = .copperPenny
//    @State var rightCurrency: Currency = .silverPenny
    
    // 使用 @State 来存储当前选择的货币
    @State private var leftCurrency: Currency = .copperPenny
    @State private var rightCurrency: Currency = .silverPenny
    
    // 使用 AppStorage 来持久化存储货币名称
    @AppStorage(UserDefaults.leftCurrencyKey) private var leftCurrencyName = Currency.copperPenny.name
    @AppStorage(UserDefaults.rightCurrencyKey) private var rightCurrencyName = Currency.silverPenny.name
    
    var body: some View {
        ZStack {
            // background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
                .onTapGesture {
                    // 取消 TextField 焦点，从而隐藏键盘
                    self.leftTyping = false
                    self.rightTyping = false
                }
            
            VStack {
                // prancing panu image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // currency conversion section
                HStack {
                    // left conversionsection
                    VStack {
                        // currency
                        HStack {
                            // currency image
                            Image(self.leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // currency text
                            Text(self.leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .onTapGesture {
                            self.showSelectedCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                        //                        .padding(.bottom, -5)
                        
                        TextField("Amount", text: self.$leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 24))
                            .focused(self.$leftTyping)
                            .keyboardType(.decimalPad)
                    }
                    
                    // equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right conversion section
                    VStack {
                        // currency
                        HStack {
                            // currency text
                            Text(self.rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            // currency image
                            Image(self.rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .onTapGesture {
                            self.showSelectedCurrency.toggle()
                        }
                        //                        .padding(.bottom,-5)
                        
                        // textField
                        TextField("Amount", text: self.$rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .font(.system(size: 24))
                            .focused(self.$rightTyping)
                            .keyboardType(.decimalPad)
                    }
                }
                .padding(25)
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                // info button
                
                HStack {
                    Spacer()
                    Button {
                        self.showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
        }
        .task {
            try? Tips.configure([
                .displayFrequency(.immediate) // 设置为每次启动都展示
            ])
        }
        .onAppear {
            if let savedLeftCurrency = Currency(rawValue: leftCurrencyName) {
                self.leftCurrency = savedLeftCurrency
            }
            if let savedRightCurrency = Currency(rawValue: rightCurrencyName) {
                self.rightCurrency = savedRightCurrency
            }
        }
        .onChange(of: self.leftAmount) {
            if self.rightTyping != true {
                self.rightAmount = self.leftCurrency
                    .convert(
                        self.leftAmount, to: self.rightCurrency
                    )
            }
        }
//        .onChange(of: leftCurrency) {
//            rightAmount = leftCurrency
//                .convert(
//                    leftAmount, to: rightCurrency
//                )
//        }
        .onChange(of: self.rightAmount) {
            if self.leftTyping != true {
                self.leftAmount = self.rightCurrency
                    .convert(self.rightAmount, to: self.leftCurrency)
            }
        }
//        .onChange(of: rightCurrency){
//            leftAmount = rightCurrency
//                .convert(rightAmount, to: leftCurrency)
//        }
        .onChange(of: self.leftCurrency) { _, newValue in
            self.leftCurrencyName = newValue.name
            self.rightAmount = self.leftCurrency.convert(self.leftAmount, to: self.rightCurrency)
        }
        .onChange(of: self.rightCurrency) { _, newValue in
            self.rightCurrencyName = newValue.name
            self.leftAmount = self.rightCurrency.convert(self.rightAmount, to: self.leftCurrency)
        }
        .sheet(isPresented: self.$showInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: self.$showSelectedCurrency) {
            SelectCurrency(
                topCurrency: self.$leftCurrency, bottomCurrency: self.$rightCurrency
            )
        }
    }
}

#Preview {
    ContentView()
}

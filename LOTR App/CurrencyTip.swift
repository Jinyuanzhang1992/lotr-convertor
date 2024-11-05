//
//  CurrencyTip.swift
//  LOTR App
//
//  Created by Jinyuan Zhang on 02/11/2024.
//

import Foundation
import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    var message: Text? {
        Text("You can tap the left or roght currency to bring up the Select Currency screen.")
    }
    
}

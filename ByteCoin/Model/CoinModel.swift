//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Михаил Позялов on 20.02.2023.
//

import Foundation

struct CoinModel {
    let rate: Double
    let currency: String
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}

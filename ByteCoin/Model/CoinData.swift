//
//  CoinData.swift
//  ByteCoin
//
//  Created by Михаил Позялов on 20.02.2023.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}

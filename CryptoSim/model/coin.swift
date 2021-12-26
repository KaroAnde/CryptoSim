//
//  coin.swift
//  CryptoSim
//
//  Created by Karoline Skumsrud Andersen on 26/12/2021.
//

import Foundation

struct Coin : Decodable, Identifiable {
    
    var id : String?
    var rank : String?
    var symbol : String?
    var name : String?
    var supply : String?
    var maxSupply : String?
    var marketCapUsd : String?
    var volumeUsd24Hr : String?
    var priceUsd : String?
    var changePercent24Hr : String?
    var vwap24Hr : String?
    var explorer : String?

}

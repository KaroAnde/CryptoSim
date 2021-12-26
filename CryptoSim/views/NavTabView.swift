//
//  NavTabView.swift
//  CryptoSim
//
//  Created by Karoline Skumsrud Andersen on 26/12/2021.
//

import SwiftUI

struct NavTabView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest( sortDescriptors: [NSSortDescriptor(keyPath: \Item.rank, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @FetchRequest( sortDescriptors: [NSSortDescriptor(keyPath: \ValueEntity.currentValue, ascending: true)],
        animation: .default)
    private var coinValue : FetchedResults<ValueEntity>
    
    @StateObject var apiContact = Api()
    
    var body: some View {
        TabView{
            CoinList(coinList: items, currentCoin: coinValue).tabItem{
                Label("CryptoCoin", systemImage: "person.fill")
            }
            
        }
    }
}

struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView()
    }
}

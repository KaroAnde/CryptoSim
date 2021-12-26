//
//  CoinList.swift
//  CryptoSim
//
//  Created by Karoline Skumsrud Andersen on 26/12/2021.
//

import SwiftUI
import URLImage

struct CoinList: View {
    
    //var coinList : [Coin]
    @Environment(\.managedObjectContext) private var viewContext
    var coinList : FetchedResults<Item>
    var currentCoin : FetchedResults<ValueEntity>
    
    
    
    var body: some View {
        VStack{
            ForEach(currentCoin){coin in
                Text("Value : $\(String(format: "%.3f", coin.currentValue))")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            List{
                ForEach(coinList) { item in
                    HStack{
                            URLImage(URL(string : "https://static.coincap.io/assets/icons/\(item.symbol!.lowercased())@2x.png" )!){ image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50, alignment: .leading)
                                    .cornerRadius(12)
                            }
                        VStack(alignment: .leading){
                            Text("\(item.name!)")
                            if((item.changePercent24Hr < 0)) {
                                Text("\(String(format: "%.3f", item.changePercent24Hr))")
                                    .foregroundColor(.red)
                            } else {
                                Text("+\(String(format: "%.3f", item.changePercent24Hr))")
                                    .foregroundColor(.green)
                            }
                        }
                        Spacer()
                        Text("$\(String(format: "%.4f", item.priceUsd))")
                    }
                    
                }
            }.onAppear(perform: test)
        }.onAppear(perform: updateCrypto)
            .background(Color("darkGreen")
            )
            
    }

    func updateCrypto () {
        
        if viewContext.hasChanges{
            do{
                try viewContext.save()
            } catch{
                viewContext.rollback()
            }
        }
        
    }
    
    func test () {
       UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color("mediumGreen"))
       UITableView.appearance().backgroundColor = UIColor(Color("mediumGreen"))
        
        
    }
    
    
}



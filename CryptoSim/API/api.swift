//
//  api.swift
//  CryptoSim
//
//  Created by Karoline Skumsrud Andersen on 26/12/2021.
//

import Foundation
import CoreData
import SwiftUI

class Api : ObservableObject {
    var viewContext = PersistenceController.shared.container.viewContext
    @Published var results = [Coin]()
    
    
    @AppStorage("launch") private var didLaunch = false
    var defaulValue = UserDefaults.standard
    
    init () {
        
        loadData()
    }
    
    func loadData(){
        let urlString = "https://api.coincap.io/v2/assets"
        guard let url = URL(string: urlString) else {
            print("Invalid")
            return
        }
        
    
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Data.self, from: data) {
                    print("fetched")
                    //Back to the main thread
                    DispatchQueue.main.async {
                        // update my UI
                        
                        self.results = decodedResponse.data
                        self.checkIfLaunched()
                        
                    }
                    
                    return
                }
            }

            // hvis jeg havner her har det gått gæli
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }).resume()
    
    }
    
    func checkIfLaunched () {
        
        //Check if app has ran once or not
        if defaulValue.bool(forKey: "launch") == true {
            defaulValue.set(true, forKey: "launch")
            print("not first time")
            
            updateCrypto()
            
        }
        else{
            defaulValue.set(true,forKey: "launch")
            print("first time")
            
            addData()
            addCoinValueOnFirstLaunch()
        }
    }
    
    func addCoinValueOnFirstLaunch(){
        let initialValue = ValueEntity(context : self.viewContext)
        initialValue.currentValue = 10000.0
        print(initialValue.currentValue)
        
        do{
            try viewContext.save()
        }
        catch {
            print("Not sure how to show user")
        }
        
    }
    
    
    func addData(){
        
        for crypto in self.results{
            
            let newCrypto = Item(context: self.viewContext)
            newCrypto.id = crypto.id
            newCrypto.name = crypto.name
            newCrypto.changePercent24Hr = Double(crypto.changePercent24Hr!) ?? 0.0
            newCrypto.priceUsd = Double(crypto.priceUsd!) ?? 0.0
            newCrypto.marketCapUsd = Double(crypto.marketCapUsd!) ?? 0.0
            newCrypto.symbol = crypto.symbol
            newCrypto.supply = Double(crypto.supply!) ?? 0.0
            newCrypto.maxSupply = Double(crypto.maxSupply ?? "") ?? 0.0
            newCrypto.volumeUsd24Hr = Double(crypto.volumeUsd24Hr!) ?? 0.0
            newCrypto.rank = Int32(crypto.rank!) ?? 0
            
            
            do{
                try viewContext.save()
            }
            catch {
                print("Not sure how to show user")
            }
            
        }
        
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
}

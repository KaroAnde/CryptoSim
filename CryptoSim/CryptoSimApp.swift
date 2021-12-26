//
//  CryptoSimApp.swift
//  CryptoSim
//
//  Created by Karoline Skumsrud Andersen on 26/12/2021.
//

import SwiftUI

@main
struct CryptoSimApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

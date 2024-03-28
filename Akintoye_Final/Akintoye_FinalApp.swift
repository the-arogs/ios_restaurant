//
//  Akintoye_FinalApp.swift
//  Akintoye_Final
//
//  Created by Arogs on 3/12/24.
//

import SwiftUI

@main
struct Akintoye_FinalApp: App {
    
    let coreDBHelper = CoreDBHelper(moc: PersistenceController.shared.container.viewContext)
    let locationHelper = LocationHelper()

    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(coreDBHelper).environmentObject(locationHelper)
        }
    }
}

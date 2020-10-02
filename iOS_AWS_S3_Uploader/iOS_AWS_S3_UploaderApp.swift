//
//  iOS_AWS_S3_UploaderApp.swift
//  iOS_AWS_S3_Uploader
//
//  Created by Roger Navarro on 10/2/20.
//

import SwiftUI

@main
struct iOS_AWS_S3_UploaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  Practica_4App.swift
//  Practica 4
//
//  Created by Álvaro García ortiz on 21/11/23.
//

import SwiftUI

@main
struct Practica_4App: App {
    @StateObject var quizzesModel = QuizzesModel()
    @StateObject var scoresModel = ScoresModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)
        }
    }
}

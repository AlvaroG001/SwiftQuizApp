//
//  ScoresModel.swift
//  Practica 4
//
//  Created by Álvaro García ortiz on 20/11/23.
//

import Foundation

class ScoresModel: ObservableObject{
    var acertadas: Set<Int> = []
    @Published private(set) var record : Set<Int> = []
    
    
    //Mostrar record
    init() {
            record = Set(UserDefaults.standard.array(forKey: "record") as? [Int]
            ?? [])
        }
    
    func  add(quizItem: QuizItem){
            acertadas.insert(quizItem.id)
            record.insert(quizItem.id)
            
            UserDefaults.standard.set(Array(record), forKey: "record")
    }
    
    func cleanUp() {
        acertadas = []
    }
}

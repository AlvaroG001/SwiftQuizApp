//
//  CheckResponseItem.swift
//  Practica_4
//
//  Created by Álvaro García ortiz on 1/12/23.
//

import Foundation

struct CheckResponseItem: Codable {
   
    let quizId: Int
    let answer: String
    let result: Bool
    
}

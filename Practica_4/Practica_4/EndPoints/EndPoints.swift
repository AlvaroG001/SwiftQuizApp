//
//  EndPoints.swift
//  Practica_4
//
//  Created by Álvaro García ortiz on 19/12/23.
//

import Foundation

let urlBase = "https://quiz.dit.upm.es"
let token = "7bcc72c5a937277744cf"

struct Endpoints {
    
    static func random10() -> URL? {
        let path = "/api/quizzes/random10"
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string: str)
    }
    
    static func checkAnswer(quizId: Int, answer: String) -> URL? {
        guard let RESPUESTA = answer.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        let str = "\(urlBase)/api/quizzes/\(quizId)/check?answer=\(RESPUESTA)&token=\(token)"
        return URL(string: str)
    }
    
    static func toggleFavURL(quizItem: QuizItem) -> URL? {
        let path = "/api/users/tokenOwner/favourites/\(quizItem.id)"
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string: str)
    }
    
    static func answer(quizId: Int) -> URL? {
        let path = "/api/quizzes/\(quizId)/answer"
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string: str)
    }
    
}

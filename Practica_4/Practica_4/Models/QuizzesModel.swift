//
//  QuizzesModel.swift
//  P4.1 Quiz
//
//  Created by Santiago Pavón Gómez on 11/9/23.
//

import Foundation

enum QuizzesModelError: Error {
    case fileNotFound
    case dataCorrupted
    case failURL
    case statusError
    case failStructureResponse
    case indexNotFound
    // Agrega más casos de errores según sea necesario
}

class QuizzesModel: ObservableObject {
    @Published private(set) var quizzes = [QuizItem]()
    @Published var errorMsg: String?

    
    let URL_BASE = "https://quiz.dit.upm.es"
        
    let quizzesPath = "api/quizzes/random10?token"
    
    private let TOKEN = "7bcc72c5a937277744cf"
    
    let favPath = "quizzes?search=&searchfavourites=1"
    
    func load() {
        do {
            guard let jsonURL = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
                throw QuizzesModelError.fileNotFound
            }
            
            let data = try Data(contentsOf: jsonURL)
            
            guard let loadedQuizzes = try? JSONDecoder().decode([QuizItem].self, from: data) else {
                throw QuizzesModelError.dataCorrupted
            }
            
            self.quizzes = loadedQuizzes
            print("Quizzes cargados")
            print("Número de quizzes cargados:", quizzes.count)
            if let firstQuiz = quizzes.first {
                print("Detalles del primer quiz:", firstQuiz)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func download() async throws{
        guard let url = Endpoints.random10() else {
            return print("Problemas al generar la URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            return print("StatusCode distinto de 200")
        }
        guard let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data) else {
            return print("Problema al generar el array de Quizzes")
        }
        self.quizzes = quizzes
        
        print("Quizzes cargados")
        print(quizzes[0])
    }
    
    //funcion para seleccionar favoritos
    func toggleFav(quizItem: QuizItem) async throws {
        guard let url = Endpoints.toggleFavURL(quizItem: quizItem) else {
            print("No puede comprobar si es Fav")
            throw QuizzesModelError.failURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("StatusCode del check distinto de 200")
            throw QuizzesModelError.statusError
            
        }
        guard let res = try? JSONDecoder().decode(FavStatusItem.self, from: data) else {
            print("Problema al generar el Fav Item")
            throw QuizzesModelError.failStructureResponse
            
        }
        
        print("Respuesta Fav cargada")
        
        guard let index = (quizzes.firstIndex {qi in qi.id == quizItem.id}) else {
            print ("UFFFFF")
            throw QuizzesModelError.indexNotFound
        }
        quizzes[index].favourite = res.favourite
        
    }

    
    //funcion para comprobar respuesta desde el servidor
    func check(quizId: Int, answer: String) async throws -> Bool {
        guard let url = Endpoints.checkAnswer(quizId: quizId, answer: answer) else {
            print("No puede comprobar la respuesta")
            throw QuizzesModelError.failURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("StatusCode del check distinto de 200")
            throw QuizzesModelError.statusError

        }
        guard let res = try? JSONDecoder().decode(CheckResponseItem.self, from: data) else {
            print("Problema al generar el Response Item")
            throw QuizzesModelError.failStructureResponse

        }
        
        print("Respuesta cargada")
        return res.result
    }
    
    
    //Funcion obtener la respuesta
    func getAnswer(quizId: Int) async throws -> String{
        guard let url = Endpoints.answer(quizId: quizId) else {
            print("No puede comprobar la respuesta")
            throw QuizzesModelError.failURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("StatusCode del check distinto de 200")
            throw QuizzesModelError.statusError

        }
        guard let res = try? JSONDecoder().decode(answerItem.self, from: data) else {
            print("Problema al generar el Response Item")
            throw QuizzesModelError.failStructureResponse

        }
        
        print("Respuesta cargada")
        return res.answer
    }
    
}

//
//  ContentView.swift
//  Practica 4
//
//  Created by Álvaro García ortiz on 21/11/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var quizzesModel: QuizzesModel
    @EnvironmentObject var scoresModel: ScoresModel
    
    @State var showErrorMsAlert = false
    @State var errorMsg = "" {
        didSet {
            showErrorMsAlert = true
        }
    }
    @State var showAll = true

    var body: some View {
        NavigationStack {
            Label("Quiz", systemImage: "scribble.variable").font(.title).bold()
            
            List{
                Toggle("Ver todos", isOn: $showAll)
                ForEach(quizzesModel.quizzes) { quiz in
                    if showAll || !scoresModel.acertadas.contains(quiz.id){
                        NavigationLink{
                            QuizDetailView(quiz: quiz)
                        } label : {
                            QuizRow(quiz: quiz)
                        }
                    }
                }
            }
            
            .navigationBarItems(leading: Text("Record = \(scoresModel.record.count)"), trailing: Button(action: {
                Task{
                    do {
                        try await quizzesModel.download()
                        scoresModel.cleanUp()
                    }catch{
                        errorMsg = error.localizedDescription
                    }
                }
            }, label: {
                Label("descargar", systemImage: "arrow.counterclockwise")
            }))
            .task{
                do {
                    guard quizzesModel.quizzes.count == 0 else {return}
                    try await quizzesModel.download()
                }catch{
                    errorMsg = error.localizedDescription
                }
            }
        }
    }
}

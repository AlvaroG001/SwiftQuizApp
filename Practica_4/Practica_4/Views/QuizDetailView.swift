//
//  QuizDetailView.swift
//  Practica 4
//
//  Created by Álvaro García ortiz on 21/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct QuizDetailView: View {
    @State var userAnswer = ""
    @State var showAlert = false
    @State var checkingResponse = false
    @State var isAnswerCorrect = false
    @State var answerForButton = ""
    
    @Environment(\.verticalSizeClass) var v
    @EnvironmentObject var scoresModel: ScoresModel
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    @State var offsetX: CGFloat = 0
    @State var opacidad: Double = 1



    var quiz: QuizItem

    var body: some View {
        if v == .compact {
            VStack{
                tituloH
                respuestaH
                imagenH
                piePagina
            }
        }else {
            VStack {
                tituloV
                respuestaV
                imagenV
                piePagina
            }
        }
    }
    
    private var tituloV: some View {
        VStack(alignment: .center) {
            HStack {
                Label("Quiz", systemImage: "scribble.variable")
                    .font(.largeTitle)
                    .bold()

                Button {
                    Task {
                        do {
                            try await quizzesModel.toggleFav(quizItem: quiz)
                        } catch {
                            print("Error boton Fav")
                        }
                    }
                } label: {
                    Image(quiz.favourite ? "FavSi" : "FavNo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }

            HStack {
                Spacer()
                Text(quiz.question)
                    .fontWeight(.heavy)
                    .font(.system(size: 20))
                    .font(.largeTitle)
                Spacer()
            }
        }
    }


    
    private var imagenV: some View {
        GeometryReader { geom in
            AsyncimageView(url: quiz.attachment?.url, isGif: quiz.attachment?.mime == "image/gif")
                .scaledToFill()
                .frame(width: geom.size.width, height: geom.size.width)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 15)
                .offset(x: offsetX)
                .opacity(opacidad)
                .onTapGesture(count: 2) {
                    Task{
                        do{
                            try await userAnswer = quizzesModel.getAnswer(quizId: quiz.id)
                        }catch{
                            print("Error al cargar respuesta")
                        }
                    }
                    withAnimation {
                        opacidad = 0
                        offsetX = geom.size.width
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation(.none) {
                            offsetX = -geom.size.width
                            opacidad = 1
                        }
                        withAnimation {
                            offsetX = 0
                        }
                    }
                }
        }
        .padding()
    }


    
    private var respuestaV: some View {
        VStack{
            TextField("Respuesta", text: $userAnswer)
                .onSubmit {
                    Task{
                        await checkAnswer()
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button(action: {
                Task{
                    await checkAnswer()
                }
            }) {
                Text("Comprobar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20) // Ajusta el espacio horizontal
                    .padding(.vertical, 10)   // Ajusta el espacio vertical
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, alignment: .center) // Ancho máximo centrado

        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Resultado"), message: Text(isAnswerCorrect ? "Correcto!" : "Incorrecto"), dismissButton: .default(Text("OK")))
        }
    }
    
    
    private var piePagina: some View {
        HStack {
            // Elemento izquierdo
            Text("\(scoresModel.acertadas.count)")
                .foregroundColor(.black)
                .font(.system(size: 25, weight: .bold))
                .padding(.leading, 15)
            
            Spacer()
            
            // Elemento derecho con padding
            HStack {
                Text((quiz.author?.username == "admin") ? "Admin" : (quiz.author?.profileName ?? "Anónimo"))
                    .font(.callout)
                
                AsyncimageView(url: quiz.author?.photo?.url, isGif: quiz.attachment?.mime == "image/gif")
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .shadow(radius: 15)
                    .task {
                            do{
                                try await answerForButton = quizzesModel.getAnswer(quizId: quiz.id)
                            }catch{
                                print("Error al cargar respuesta")
                            }
                    }
                    .contextMenu{
                        Button(action: {userAnswer = ""}){
                            Label("Borrar", systemImage: "trash.slash")
                        }
                        Button(action: {userAnswer = answerForButton}){
                            Label("Respuesta", systemImage: "pencil")
                        }
                        
                    }
            }
            .font(.callout)
            .padding(.trailing, 15) // Agrega padding a la derecha para evitar el corte
        }
    }
    
    private var tituloH: some View {
        VStack(alignment: .center) {
            HStack {
                Label("Quiz", systemImage: "scribble.variable")
                    .font(.largeTitle)
                    .bold()

                Button {
                    Task {
                        do {
                            try await quizzesModel.toggleFav(quizItem: quiz)
                        } catch {
                            print("Error boton Fav")
                        }
                    }
                } label: {
                    Image(quiz.favourite ? "FavSi" : "FavNo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }

            HStack {
                Spacer()
                Text(quiz.question)
                    .fontWeight(.heavy)
                    .font(.system(size: 15))
                    .font(.largeTitle)
                Spacer()
            }
        }
    }
    
    private var imagenH: some View{
        GeometryReader{ geom in
            AsyncimageView(url: quiz.attachment?.url, isGif: quiz.attachment?.mime == "image/gif")
                .scaledToFill ()
                .frame(width: 200,height:  200)
                .clipShape(RoundedRectangle (cornerRadius: 20 ))
                .shadow(radius: 15)
                .frame(width: geom.size.width * 1) // Ajusta el tamaño
                .offset(x: offsetX)
                .opacity(opacidad)
                .onTapGesture(count: 2) {
                    Task{
                        do{
                            try await userAnswer = quizzesModel.getAnswer(quizId: quiz.id)
                        }catch{
                            print("Error al cargar respuesta")
                        }
                    }
                    withAnimation {
                        opacidad = 0
                        offsetX = geom.size.width
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation(.none) {
                            offsetX = -geom.size.width
                            opacidad = 1
                        }
                        withAnimation {
                            offsetX = 0
                        }
                    }
                }
        }
        .padding()
    }
    
    private var respuestaH: some View {
        VStack{
            TextField("Respuesta", text: $userAnswer)
                .onSubmit {
                    Task{
                        await checkAnswer()
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button(action: {
                Task{
                    await checkAnswer()
                }
            }) {
                Text("Comprobar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20) // Ajusta el espacio horizontal
                    .padding(.vertical, 10)   // Ajusta el espacio vertical
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, alignment: .center) // Ancho máximo centrado
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Resultado"), message: Text(isAnswerCorrect ? "Correcto!" : "Incorrecto"), dismissButton: .default(Text("OK")))
        }
    }

    
    func checkAnswer() async {
        do{
            checkingResponse = true
            isAnswerCorrect = try await quizzesModel.check(quizId: quiz.id, answer: userAnswer)
            if isAnswerCorrect {
                scoresModel.add(quizItem: quiz)
            }
            checkingResponse = false
        }catch{
            print("Error en checkAnswer")
        }
        showAlert = true
    }
}

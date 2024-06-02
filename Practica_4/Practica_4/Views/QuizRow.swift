//
//  QuizRow.swift
//  Practica 4
//
//  Created by Álvaro García ortiz on 21/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct QuizRow: View {
    var quiz: QuizItem

    var body: some View {
        HStack {
            // Imagen a la izquierda ocupando 1/5 del espacio
            AsyncimageView(url: quiz.attachment?.url, isGif: quiz.attachment?.mime == "image/gif")
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width / 5, height: 80) // Ajusta el tamaño según tu preferencia
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.orange, lineWidth: 4))

            // VStack para el texto de la pregunta y las imágenes debajo
            VStack(alignment: .leading) {
                Text(quiz.question)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3) // Elige el número de líneas que deseas mostrar
                    .truncationMode(.tail) // Establece el estilo de truncado a punto
                
                HStack {
                    // Imagen de "favorito" a la izquierda
                    Image(quiz.favourite ? "FavSi": "FavNo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 20)
                    
                    Spacer() // Espacio entre la imagen del autor y la de "favorito"
                    
                    // Imagen del autor a la derecha
                    Text((quiz.author?.username == "admin") ? "Admin" : (quiz.author?.profileName ?? "Anónimo"))
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                    
                    AsyncimageView(url: quiz.author?.photo?.url, isGif: quiz.attachment?.mime == "image/gif")
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                }
                .padding(.top, 8) // Espacio superior para separar las imágenes del texto
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8) // Espacio para separar el texto de las imágenes
        }
        .padding(8) // Añade un espacio uniforme alrededor de la fila
    }
}



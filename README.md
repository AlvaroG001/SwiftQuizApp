# Practica_4 Quiz App

Una aplicación de cuestionarios desarrollada en Swift que permite a los usuarios responder preguntas, comprobar respuestas y marcar sus favoritos. Esta aplicación utiliza una API remota para obtener los datos de los cuestionarios.

## Contenido

- [Instalación](#instalación)
- [Uso](#uso)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Endpoints](#endpoints)
- [Modelos](#modelos)
- [Vistas](#vistas)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Instalación

1. Clona este repositorio:
    ```sh
    git clone https://github.com/tu-usuario/Practica_4.git
    ```
2. Abre el proyecto en Xcode:
    ```sh
    cd Practica_4
    open Practica_4.xcodeproj
    ```
3. Asegúrate de tener instaladas las dependencias utilizando Swift Package Manager:
    ```sh
    File > Swift Packages > Update to Latest Package Versions
    ```
4. Compila y corre la aplicación en el simulador o en tu dispositivo iOS.

## Uso

1. Al iniciar la aplicación, se descargan los cuestionarios de la API.
2. Puedes ver la lista de cuestionarios y navegar a los detalles de cada uno.
3. Responde a las preguntas y comprueba tus respuestas.
4. Marca tus cuestionarios favoritos para tener un acceso rápido a ellos.

## Estructura del Proyecto

- **EndPoints.swift**: Define los endpoints de la API.
- **QuizzesModel.swift**: Modelo para manejar los datos de los cuestionarios.
- **ScoresModel.swift**: Modelo para manejar las puntuaciones y registros de cuestionarios acertados.
- **CheckResponseItem.swift**: Modelo para la respuesta del servidor al comprobar una respuesta.
- **QuizItem.swift**: Modelo para representar un cuestionario.
- **FavStatusItem.swift**: Modelo para manejar el estado de los favoritos.
- **answerItem.swift**: Modelo para manejar la respuesta correcta del servidor.
- **ContentView.swift**: Vista principal de la aplicación.
- **AsyncimageView.swift**: Componente para cargar imágenes de manera asíncrona.
- **QuizDetailView.swift**: Vista para mostrar los detalles de un cuestionario.
- **QuizRow.swift**: Vista para representar una fila de cuestionario en la lista.
- **Practica_4App.swift**: Punto de entrada de la aplicación.

## Endpoints

La clase `Endpoints` define los siguientes métodos para interactuar con la API:

- `random10() -> URL?`: Obtiene 10 cuestionarios aleatorios.
- `checkAnswer(quizId: Int, answer: String) -> URL?`: Verifica la respuesta de un cuestionario.
- `toggleFavURL(quizItem: QuizItem) -> URL?`: Marca o desmarca un cuestionario como favorito.
- `answer(quizId: Int) -> URL?`: Obtiene la respuesta correcta de un cuestionario.

## Modelos

- **QuizzesModel**: Maneja la lógica de negocio para cargar y descargar cuestionarios.
- **ScoresModel**: Maneja las puntuaciones y registros de cuestionarios acertados.
- **CheckResponseItem**: Modelo de datos para la respuesta de verificación.
- **QuizItem**: Representa un cuestionario.
- **FavStatusItem**: Maneja el estado de favorito de un cuestionario.
- **answerItem**: Representa la respuesta correcta de un cuestionario.

## Vistas

- **ContentView**: Vista principal que muestra la lista de cuestionarios.
- **AsyncimageView**: Componente para cargar imágenes de manera asíncrona.
- **QuizDetailView**: Vista para mostrar los detalles de un cuestionario.
- **QuizRow**: Vista para representar una fila de cuestionario en la lista.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue para discutir cualquier cambio importante antes de enviar un pull request.

1. Fork este repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Haz tus cambios y haz commit (`git commit -am 'Añadir nueva funcionalidad'`).
4. Haz push a la rama (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Para más detalles, consulta el archivo [LICENSE](LICENSE).


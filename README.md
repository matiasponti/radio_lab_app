# 🎧 Radio Lab App
Este proyecto es una app para escuchar estaciones de radio online hecha con Flutter. Lo hice como parte de un test técnico.

## 🚀 Características principales
- Lista de estaciones de radio (filtradas por calidad y popularidad)
- Mini reproductor flotante visible desde cualquier pantalla
- Favoritos guardados localmente usando `shared_preferences`
- Navegación simple con estado compartido usando Bloc

## 🔐 Seguridad integrada
- Las URLs de las estaciones están cifradas en runtime.
- La URL del endpoint principal está oculta y cifrada también.
- Se usa AES con una clave fija para evitar que se vean valores en texto plano. Esto sirve para proteger el contenido de la app contra inspecciones simples o scraping.

## 🧪 Tests
- Hay un test unitario que se encarga de verificar que el sistema de cifrado y descifrado funciona como debe.

Para correrlo:
```bash
flutter test
🧑‍💻 Cómo correrlo en tu compu
Cloná el repo

bash
Copiar
git clone https://github.com/matiasponti/radio_lab_app.git
cd radio_lab_app
Instalá las dependencias

bash
Copiar
flutter pub get
Corré la app

bash
Copiar
flutter run
💻 Requisitos del sistema
Flutter SDK 3.3.10

Dart SDK 3.5.3

Un emulador o dispositivo físico Android/iOS

Conexión a internet

📦 Paquetes usados
flutter_bloc para el manejo de estado

just_audio para la reproducción de audio

encrypt para cifrar y descifrar strings

shared_preferences para guardar favoritos

🚨 Manejo de Errores y URL No Funcionantes
Dado que la API utilizada en la app es pública, algunas URLs de estaciones de radio pueden no funcionar o estar fuera de servicio. Por eso, implementamos un manejo de errores para detectar cuando una URL no es válida antes de intentar reproducirla. Si una URL no responde correctamente, mostramos un mensaje de error o intentamos con una URL alternativa.

También puedes revisar el estado de la URL usando el siguiente código de ejemplo:

dart
Copiar
import 'package:http/http.dart' as http;

Future<bool> isValidUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  } catch (e) {
    print("Error al validar la URL: $e");
    return false;
  }
}
Si la URL no es válida, la app muestra un mensaje de error apropiado.

⚠️ Pequeño Bug en el Primer onPressed
Al abrir la app por primera vez, puede haber un pequeño retraso en la interacción con el primer onPressed debido a la inicialización del estado o la carga de recursos. Para solucionar esto, se ha implementado un retraso en la inicialización de la interacción, utilizando Future.delayed() para asegurar que los recursos estén completamente listos antes de permitir que el usuario interactúe con la app.


@override
void initState() {
  super.initState();
  _delayedInit();
}
Matías Ponti
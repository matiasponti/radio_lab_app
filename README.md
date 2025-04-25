# 🎧 Radio Lab App

Este proyecto es una app para escuchar estaciones de radio online hecha con Flutter. Lo hice como parte de un test técnico.

---

## 🚀 Características principales

- Lista de estaciones de radio (filtradas por calidad y popularidad)
- Mini reproductor flotante visible desde cualquier pantalla
- Favoritos guardados localmente usando `shared_preferences`
- Navegación simple con estado compartido usando `Bloc`

---

## 🔐 Seguridad integrada

- Las URLs de las estaciones están **cifradas en runtime**
- La URL del endpoint principal está **oculta y cifrada** también
- Se usa `AES` con una clave fija para evitar que se vean valores en texto plano

Esto sirve para proteger el contenido de la app contra inspecciones simples o scraping.

---

## 🧪 Tests

Hay un test unitario que se encarga de verificar que el sistema de cifrado y descifrado funciona como debe.

Para correrlo:
```bash
flutter test
```

---

## 🧑‍💻 Cómo correrlo en tu compu

### 1. Cloná el repo
```bash
git clone https://github.com/matiasponti/radio_lab_app.git
cd radio_lab_app
```

### 2. Instalá las dependencias
```bash
flutter pub get
```

### 3. Corré la app
```bash
flutter run
```

---

## 💻 Requisitos del sistema

- Flutter SDK **3.3.10**
- Dart SDK **3.5.3** 
- Un emulador o dispositivo físico Android/iOS
- Conexión a internet

---

## 📦 Paquetes usados

- `flutter_bloc` para el manejo de estado
- `just_audio` para la reproducción de audio
- `encrypt` para cifrar y descifrar strings
- `shared_preferences` para guardar favoritos

---

Matías Ponti


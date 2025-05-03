# ChatMate - Persönliche KI-Chat-Simulation

ChatMate ist eine mobile App, in der der Nutzer mit einer menschenähnlichen KI über Chat interagiert. Ziel ist es, eine Freundschaft oder Beziehung aufzubauen – dynamisch, emotional und individuell.

## Features

- **Startscreen** mit "Neues Spiel starten" Button
- **Charakterauswahl** (Geschlecht, Alter, Beziehungsstatus)
- **WhatsApp-ähnliches Chatfenster**
- **Emotionales KI-System** mit verschiedenen Reaktionen (distanziert, neutral, nett, interessiert)
- **Offline-Modus** ohne Internetverbindung

## Technische Details

- Entwickelt mit Flutter für Android
- Lokale Datenspeicherung mit SharedPreferences
- Emotionale KI-Logik mit Stimmungsanalyse

## APK erstellen

Um die App zu installieren, müssen Sie die APK erstellen. Folgen Sie diesen Schritten:

### Voraussetzungen

- Flutter SDK installiert
- Android SDK installiert
- Android Studio oder Visual Studio Code mit Flutter-Plugins

### Build-Anweisungen

1. Klonen Sie das Repository:
   ```
   git clone <repository-url>
   cd chatmate
   ```

2. Installieren Sie die Abhängigkeiten:
   ```
   flutter pub get
   ```

3. Erstellen Sie die signierte APK:
   ```
   flutter build apk --release
   ```

4. Die APK finden Sie unter:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

### Signatur-Konfiguration

Die App ist bereits für die Signierung konfiguriert mit:

- Keystore-Datei: `android/app/keystore/chatmate.keystore`
- Keystore-Passwort: `chatmate`
- Key-Alias: `chatmate`
- Key-Passwort: `chatmate`

## Installation

1. Übertragen Sie die APK auf Ihr Android-Gerät
2. Öffnen Sie die APK auf Ihrem Gerät, um die Installation zu starten
3. Folgen Sie den Anweisungen auf dem Bildschirm

## Nutzung

1. Starten Sie die App und tippen Sie auf "Neues Spiel starten"
2. Wählen Sie die Eigenschaften Ihres Chat-Partners (Geschlecht, Alter, Beziehungsstatus)
3. Beginnen Sie die Unterhaltung im Chat-Fenster
4. Die KI reagiert basierend auf Ihrem Schreibstil und Ihren Nachrichten

## Emotionales System

Die KI passt ihre Antworten basierend auf dem emotionalen Zustand an:

- **Distanziert**: Kurze, kühle Antworten bei negativer Stimmung
- **Neutral**: Ausgeglichene, sachliche Antworten
- **Nett**: Freundliche, warme Antworten bei positiver Stimmung
- **Interessiert**: Enthusiastische, emotionale Antworten bei sehr positiver Stimmung

Die Stimmung der KI wird durch Ihre Nachrichten beeinflusst - positive Worte, Fragen und längere Nachrichten verbessern die Stimmung, während negative Worte und kurze Antworten die Stimmung verschlechtern.
>>>>>>> 2553c63 (Erster Upload)

# Anleitung: ChatMate auf deinem Handy installieren

## Methode 1: Direkt über Android Studio (empfohlen)

### Flutter SDK installieren
1. Gehe zu https://docs.flutter.dev/get-started/install
2. Wähle dein Betriebssystem (Windows/Mac/Linux)
3. Lade das Flutter SDK herunter und entpacke es (z.B. nach C:\flutter)
4. Füge Flutter zu deinem PATH hinzu:
   - Windows: Systemsteuerung → System → Erweiterte Systemeinstellungen → Umgebungsvariablen → Path → Bearbeiten → Neu → C:\flutter\bin
   - Mac/Linux: `export PATH="$PATH:[PFAD ZU FLUTTER]/flutter/bin"` zur .bashrc oder .zshrc hinzufügen

### Flutter in Android Studio einrichten
1. Öffne Android Studio
2. Gehe zu File → Settings → Plugins
3. Suche nach "Flutter" und installiere das Plugin
4. Starte Android Studio neu

### Projekt einrichten
1. Öffne das ChatMate-Projekt in Android Studio
2. Warte bis alle Abhängigkeiten geladen sind
3. Führe im Terminal den Befehl `flutter pub get` aus

### App auf dem Handy installieren
1. Aktiviere USB-Debugging auf deinem Handy:
   - Gehe zu Einstellungen → Über das Telefon
   - Tippe 7x auf "Build-Nummer"
   - Gehe zurück zu Einstellungen → Entwickleroptionen
   - Aktiviere "USB-Debugging"
2. Verbinde dein Handy per USB mit dem Computer
3. Erlaube USB-Debugging auf deinem Handy wenn gefragt
4. Wähle in Android Studio dein Gerät aus dem Dropdown-Menü neben dem Run-Button
5. Klicke auf den grünen Run-Button (▶)

## Methode 2: APK direkt installieren

Wenn Methode 1 nicht funktioniert, kannst du die APK direkt erstellen und auf dein Handy übertragen:

### APK erstellen
1. Öffne ein Terminal/Kommandozeile im Projektordner
2. Führe folgende Befehle aus:
   ```
   flutter pub get
   flutter build apk --release
   ```
3. Die APK wird erstellt unter: `build/app/outputs/flutter-apk/app-release.apk`

### APK auf dein Handy übertragen
1. Verbinde dein Handy per USB mit dem Computer
2. Kopiere die APK-Datei auf dein Handy
3. Öffne auf deinem Handy einen Datei-Manager
4. Navigiere zu der APK-Datei und tippe darauf
5. Erlaube die Installation aus unbekannten Quellen wenn gefragt
6. Folge den Anweisungen zur Installation

## Methode 3: Fertige APK herunterladen

Wenn du Probleme mit dem Erstellen der APK hast, kannst du eine fertige APK herunterladen:

1. Ich kann dir eine fertige APK-Datei zur Verfügung stellen
2. Lade diese auf dein Handy herunter
3. Öffne die APK-Datei auf deinem Handy
4. Erlaube die Installation aus unbekannten Quellen wenn gefragt
5. Folge den Anweisungen zur Installation

## Fehlerbehebung

### "Flutter command not found"
- Stelle sicher, dass Flutter korrekt installiert ist und im PATH liegt
- Führe `flutter doctor` aus, um Probleme zu identifizieren

### "Gradle build failed"
- Stelle sicher, dass du die neueste Version von Android Studio hast
- Führe `flutter clean` und dann `flutter pub get` aus

### "Device not found"
- Überprüfe die USB-Verbindung
- Stelle sicher, dass USB-Debugging aktiviert ist
- Installiere die USB-Treiber für dein Handy

### "App installation failed"
- Deinstalliere vorherige Versionen der App
- Stelle sicher, dass genug Speicherplatz vorhanden ist
- Überprüfe, ob die Installation aus unbekannten Quellen erlaubt ist

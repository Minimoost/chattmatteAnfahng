# Flutter Installation und ChatMate Einrichtung

## 1. Flutter SDK installieren

### Für Windows:
1. Besuche [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. Lade das Flutter SDK herunter (ZIP-Datei)
3. Entpacke die ZIP-Datei an einen Ort ohne Leerzeichen (z.B. `C:\Flutter`)
4. Füge Flutter zu deinem PATH hinzu:
   - Suche in Windows nach "Umgebungsvariablen"
   - Klicke auf "Umgebungsvariablen bearbeiten"
   - Unter "Systemvariablen", wähle "Path" und klicke auf "Bearbeiten"
   - Klicke auf "Neu" und füge den Pfad zum Flutter `bin`-Ordner hinzu (z.B. `C:\Flutter\bin`)
   - Klicke auf "OK" um alle Dialoge zu schließen

### Für macOS:
1. Besuche [flutter.dev](https://flutter.dev/docs/get-started/install/macos)
2. Lade das Flutter SDK herunter
3. Entpacke die ZIP-Datei:
   ```
   cd ~/Downloads
   unzip flutter_macos_3.19.3-stable.zip
   ```
4. Verschiebe Flutter an einen permanenten Ort:
   ```
   mkdir -p ~/Development
   mv ~/Downloads/flutter ~/Development
   ```
5. Füge Flutter zu deinem PATH hinzu:
   - Öffne Terminal
   - Führe aus: `nano ~/.zshrc` oder `nano ~/.bash_profile`
   - Füge diese Zeile hinzu: `export PATH="$PATH:$HOME/Development/flutter/bin"`
   - Speichere mit CTRL+O, dann ENTER, dann CTRL+X
   - Führe aus: `source ~/.zshrc` oder `source ~/.bash_profile`

### Für Linux:
1. Besuche [flutter.dev](https://flutter.dev/docs/get-started/install/linux)
2. Lade das Flutter SDK herunter
3. Entpacke die TAR-Datei:
   ```
   cd ~/Downloads
   tar xf flutter_linux_3.19.3-stable.tar.xz
   ```
4. Verschiebe Flutter an einen permanenten Ort:
   ```
   mkdir -p ~/Development
   mv ~/Downloads/flutter ~/Development
   ```
5. Füge Flutter zu deinem PATH hinzu:
   - Öffne Terminal
   - Führe aus: `nano ~/.bashrc`
   - Füge diese Zeile hinzu: `export PATH="$PATH:$HOME/Development/flutter/bin"`
   - Speichere mit CTRL+O, dann ENTER, dann CTRL+X
   - Führe aus: `source ~/.bashrc`

## 2. Flutter überprüfen

Öffne ein neues Terminal/Kommandozeile und führe aus:
```
flutter --version
```

Du solltest die Flutter-Version sehen. Dann führe aus:
```
flutter doctor
```

Dies zeigt dir, ob noch etwas fehlt für die Flutter-Entwicklung.

## 3. Android Studio einrichten

1. Falls noch nicht installiert, lade [Android Studio](https://developer.android.com/studio) herunter und installiere es
2. Starte Android Studio
3. Wenn du zum ersten Mal startest, führe den Setup-Wizard durch und installiere die empfohlenen SDK-Tools
4. Installiere das Flutter-Plugin:
   - Öffne Android Studio
   - Gehe zu File > Settings > Plugins (Windows/Linux) oder Android Studio > Preferences > Plugins (macOS)
   - Suche nach "Flutter"
   - Klicke auf "Install"
   - Wenn du aufgefordert wirst, das Dart-Plugin zu installieren, bestätige dies
   - Starte Android Studio neu

## 4. ChatMate Projekt öffnen

1. Entpacke die ChatMate ZIP-Datei, die ich dir gesendet habe
2. In Android Studio, klicke auf "Open an existing project"
3. Navigiere zum entpackten ChatMate-Ordner und wähle ihn aus
4. Warte, bis Android Studio das Projekt geladen hat und die Abhängigkeiten installiert sind

## 5. Abhängigkeiten installieren

1. Öffne ein Terminal in Android Studio (unten im Fenster)
2. Führe aus:
   ```
   flutter pub get
   ```
3. Warte, bis alle Abhängigkeiten installiert sind

## 6. Verbinde dein Android-Gerät

1. Aktiviere auf deinem Android-Gerät den Entwicklermodus:
   - Gehe zu Einstellungen > Über das Telefon
   - Tippe 7 Mal auf "Build-Nummer"
   - Du solltest eine Meldung sehen, dass du jetzt ein Entwickler bist
2. Aktiviere USB-Debugging:
   - Gehe zu Einstellungen > System > Entwickleroptionen
   - Aktiviere "USB-Debugging"
3. Verbinde dein Gerät per USB mit dem Computer
4. Erlaube USB-Debugging auf deinem Gerät, wenn du dazu aufgefordert wirst

## 7. App auf dem Gerät ausführen

1. In Android Studio, klicke oben auf das Dropdown-Menü neben dem Play-Button
2. Wähle dein verbundenes Gerät aus
3. Klicke auf den Play-Button (grüner Dreieck-Button)
4. Warte, während die App auf dein Gerät installiert und gestartet wird

## 8. Fehlerbehebung

Wenn du Probleme hast:

1. **Flutter nicht gefunden**: Stelle sicher, dass Flutter korrekt zu deinem PATH hinzugefügt wurde
2. **Gerät nicht erkannt**: 
   - Überprüfe die USB-Verbindung
   - Stelle sicher, dass USB-Debugging aktiviert ist
   - Installiere die USB-Treiber für dein Gerät
3. **Gradle-Fehler**: 
   - Führe `flutter clean` aus und versuche es erneut
   - Stelle sicher, dass du eine stabile Internetverbindung hast

## 9. Nächste Schritte

Sobald die App auf deinem Gerät läuft, kannst du:

1. Einen Charakter erstellen (Geschlecht, Alter, Beziehungsstatus, Persönlichkeit)
2. Mit dem Charakter chatten und die emotionalen Reaktionen beobachten
3. Die verschiedenen Stimmungen und Persönlichkeiten testen

Bei weiteren Fragen oder Problemen stehe ich dir gerne zur Verfügung!

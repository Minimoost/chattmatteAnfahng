# ChatMate - Manuelle Upload-Anleitung für den Google Play Store

Da wir auf technische Herausforderungen beim automatisierten Upload gestoßen sind, habe ich diese detaillierte Anleitung erstellt, damit du die ChatMate-App manuell im Google Play Store hochladen kannst.

## Voraussetzungen

1. Ein verifiziertes Google Play Developer-Konto
2. Eine signierte APK- oder AAB-Datei der ChatMate-App
3. Alle vorbereiteten Store-Materialien (bereits in diesem Projekt enthalten)

## Schritt 1: APK/AAB-Datei erstellen

### Option A: Lokaler Build (empfohlen)
1. Installiere Flutter und das Android SDK auf deinem Computer
2. Klone das ChatMate-Repository
3. Führe folgende Befehle aus:
   ```
   cd chatmate
   flutter build appbundle --release
   ```
4. Die AAB-Datei findest du unter: `build/app/outputs/bundle/release/app-release.aab`

### Option B: Verwende einen Online-Build-Service
1. Lade den Quellcode auf einen Dienst wie Appetize.io oder AppCenter hoch
2. Konfiguriere den Build für Android
3. Lade die generierte APK/AAB-Datei herunter

## Schritt 2: Google Play Console öffnen

1. Gehe zu [Google Play Console](https://play.google.com/console/)
2. Melde dich mit deinem Google-Konto an
3. Klicke auf "App erstellen" (oder wähle deine bestehende ChatMate-App)

## Schritt 3: App-Informationen eingeben

1. App-Name: "ChatMate"
2. Standardsprache: "Deutsch"
3. App- oder Spiel: "Spiel"
4. Kostenlos oder kostenpflichtig: "Kostenlos" (mit In-App-Käufen)
5. Bestätige die Erklärungen und klicke auf "App erstellen"

## Schritt 4: Store-Präsenz einrichten

### App-Details
1. Gehe zu "Store-Präsenz" > "Store-Eintrag"
2. Fülle die folgenden Felder aus:

#### App-Name
```
ChatMate
```

#### Kurze Beschreibung
```
Baue eine einzigartige Beziehung mit einer KI auf - emotional und individuell.
```

#### Vollständige Beschreibung
Kopiere den Inhalt aus der Datei `play_store_listing.md` in dieses Feld.

### Grafiken hochladen
1. App-Symbol: Verwende das Icon aus dem Ordner `store_assets/icon/`
2. Feature-Grafik: Verwende die Grafik aus dem Ordner `store_assets/feature_graphic/`
3. Screenshots: Verwende die Screenshots aus dem Ordner `store_assets/screenshots/`

### Kategorisierung
1. Kategorie: "Spiele" > "Simulation"
2. Tags: "Chat, KI, Simulation, Beziehung, Premium"

### Kontaktdaten
1. E-Mail-Adresse: Deine E-Mail-Adresse
2. Website (optional): Deine Website, falls vorhanden
3. Telefon (optional): Deine Telefonnummer, falls gewünscht

### Datenschutzerklärung
Kopiere den Inhalt aus der Datei `privacy_policy.md` in ein HTML-Dokument und lade es hoch oder gib die URL deiner Datenschutzerklärung an.

## Schritt 5: Inhaltsklassifizierung

1. Gehe zu "App-Inhalte" > "Content Rating"
2. Fülle den Fragebogen wie folgt aus:
   - Kategorie: "Soziale Netzwerke, Kommunikation oder andere App mit nutzergenerierten Inhalten"
   - Gewalt: "Nein"
   - Sex: "Nein"
   - Sprache: "Leichte Kraftausdrücke"
   - Drogen: "Nein"
   - Nutzergenerierte Inhalte: "Nein"
   - Handel: "Ja, digitale Artikel mit festem Preis"

## Schritt 6: Zielgruppe & Inhalte

1. Gehe zu "App-Inhalte" > "Zielgruppe & Inhalte"
2. Wähle die Altersgruppen:
   - [ ] Unter 13 Jahren
   - [x] 13-17 Jahre
   - [x] 18 Jahre und älter
3. Richtet sich deine App speziell an Kinder? "Nein"
4. Enthält deine App Werbung? "Nein"
5. Enthält oder ermöglicht deine App nutzergenerierte Inhalte? "Nein"
6. Enthält deine App anstößige Inhalte? "Nein"

## Schritt 7: In-App-Käufe einrichten

1. Gehe zu "Monetarisierung" > "In-App-Produkte"
2. Klicke auf "Produkt erstellen"
3. Produkttyp: "Managed product" (Verwaltetes Produkt)
4. Produkt-ID: "chatmate_premium"
5. Name: "ChatMate Premium"
6. Beschreibung:
   ```
   Schalte alle Premium-Funktionen frei: Erweiterte Persönlichkeiten, Bildaustausch, Sprachnachrichten, thematische Hintergründe und Chat-Statistiken.
   ```
7. Preis: 3,99 EUR
8. Klicke auf "Speichern"

## Schritt 8: App-Version hochladen

1. Gehe zu "Produktion" > "App-Veröffentlichungen"
2. Klicke auf "Neue Version erstellen"
3. Lade die APK/AAB-Datei hoch
4. Gib die Versionsinformationen ein:
   - Versionscode: 1
   - Versionsname: "1.0.0"
   - Versionshinweise: "Erste Version von ChatMate mit allen Grundfunktionen und Premium-Features."

## Schritt 9: App-Veröffentlichung

1. Überprüfe alle Abschnitte und stelle sicher, dass sie als "Abgeschlossen" markiert sind
2. Gehe zu "Produktion" > "App-Veröffentlichungen"
3. Klicke auf "Überprüfen"
4. Überprüfe alle Informationen
5. Klicke auf "Starten", um die App zur Überprüfung einzureichen

## Wichtige Hinweise

- Die Überprüfung durch Google kann 1-7 Tage dauern
- Stelle sicher, dass alle Informationen korrekt und vollständig sind
- Halte dich an alle Google Play-Richtlinien
- Bereite dich darauf vor, auf Feedback von Google zu reagieren, falls Änderungen erforderlich sind

## Fehlerbehebung

Falls Probleme auftreten, konsultiere die Datei `play_store_submission_troubleshooting.md` für Lösungsvorschläge zu häufigen Problemen.

## Nächste Schritte nach der Veröffentlichung

1. Überwache die App-Performance und Nutzerfeedback
2. Plane Updates und neue Funktionen
3. Optimiere die Store-Präsenz basierend auf Nutzerdaten
4. Erwäge Marketing-Maßnahmen, um die App zu bewerben

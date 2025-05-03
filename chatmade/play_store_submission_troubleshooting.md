# ChatMate - Fehlerbehebung bei der Google Play Store-Einreichung

Diese Anleitung hilft dir, häufige Probleme bei der Einreichung im Google Play Store zu lösen.

## APK/App Bundle Probleme

### Problem: "APK wurde nicht signiert"
**Lösung:**
- Überprüfe, ob die Keystore-Datei korrekt in Codemagic hochgeladen wurde
- Stelle sicher, dass die Keystore-Passwörter korrekt sind
- Prüfe, ob die key.properties-Datei korrekt konfiguriert ist

### Problem: "APK hat eine ungültige Versionsnummer"
**Lösung:**
- Überprüfe die Versionsnummer in der pubspec.yaml-Datei
- Stelle sicher, dass die Versionsnummer höher ist als die vorherige Version
- Format sollte sein: `version: 1.0.0+1` (versionName+versionCode)

### Problem: "APK ist zu groß"
**Lösung:**
- Verwende App Bundle statt APK
- Optimiere Bilder und Assets
- Entferne nicht verwendete Ressourcen

## Store-Listing Probleme

### Problem: "Beschreibung enthält unzulässige Inhalte"
**Lösung:**
- Entferne Verweise auf andere Apps oder Plattformen
- Vermeide übertriebene Behauptungen
- Halte dich an die Google Play-Richtlinien

### Problem: "Screenshots entsprechen nicht den Anforderungen"
**Lösung:**
- Stelle sicher, dass die Screenshots die richtigen Abmessungen haben
- Verwende Screenshots ohne Geräterahmen
- Zeige tatsächliche App-Inhalte ohne Werbetexte

### Problem: "Datenschutzerklärung URL ist ungültig"
**Lösung:**
- Stelle sicher, dass die URL erreichbar ist
- Verwende HTTPS statt HTTP
- Prüfe, ob die Datenschutzerklärung alle erforderlichen Informationen enthält

## In-App-Käufe Probleme

### Problem: "In-App-Kauf kann nicht getestet werden"
**Lösung:**
- Stelle sicher, dass ein Testkonto eingerichtet ist
- Füge Testgeräte zur Lizenzprüfung hinzu
- Überprüfe, ob die In-App-Käufe korrekt implementiert sind

### Problem: "In-App-Kauf entspricht nicht den Richtlinien"
**Lösung:**
- Stelle sicher, dass die Beschreibung klar ist
- Vermeide irreführende Angaben zum Preis oder Inhalt
- Halte dich an die Google Play-Richtlinien für In-App-Käufe

## Datensicherheit Probleme

### Problem: "Datensicherheitsformular ist unvollständig"
**Lösung:**
- Fülle alle erforderlichen Felder aus
- Gib an, dass die App keine Daten sammelt (falls zutreffend)
- Sei transparent über alle gesammelten Daten

### Problem: "Datensicherheitsangaben stimmen nicht mit der App überein"
**Lösung:**
- Überprüfe die tatsächliche Datenerfassung in der App
- Aktualisiere die Angaben entsprechend
- Stelle sicher, dass die Datenschutzerklärung mit den Angaben übereinstimmt

## Allgemeine Probleme

### Problem: "App wurde abgelehnt"
**Lösung:**
- Lies die Ablehnungsgründe sorgfältig
- Behebe alle angegebenen Probleme
- Reiche die App erneut ein mit einer Erklärung der Änderungen

### Problem: "App ist im Prüfungsprozess stecken geblieben"
**Lösung:**
- Warte mindestens 7 Tage
- Kontaktiere den Google Play Support
- Überprüfe, ob es Benachrichtigungen gibt, die Aufmerksamkeit erfordern

## Kontakt zum Google Play Support

Wenn du Probleme nicht selbst lösen kannst:
1. Gehe zur Google Play Console
2. Klicke auf "Support" in der linken Seitenleiste
3. Wähle "Kontakt" und beschreibe dein Problem
4. Füge Screenshots und relevante Informationen hinzu

## Wichtige Hinweise

- Plane genügend Zeit für die Überprüfung ein (1-7 Tage)
- Halte dich an alle Google Play-Richtlinien
- Teste die App gründlich, bevor du sie einreichst
- Bereite alle erforderlichen Materialien vor der Einreichung vor

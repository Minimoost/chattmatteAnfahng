# ChatMate - In-App-Kauf Einrichtung im Google Play Store

Diese Anleitung führt dich durch den Prozess der Einrichtung des In-App-Kaufs für ChatMate Premium im Google Play Store.

## Voraussetzungen

- Ein Google Play Developer-Konto
- Die ChatMate-App wurde bereits im Google Play Store erstellt
- Ein Merchant-Konto ist mit deinem Google Play Developer-Konto verknüpft

## Schritt 1: In-App-Produkt erstellen

1. Gehe zur [Google Play Console](https://play.google.com/console/)
2. Wähle deine ChatMate-App aus
3. Klicke im linken Menü auf "Monetarisierung" > "In-App-Produkte"
4. Klicke auf "Produkt erstellen"
5. Wähle "Managed product" (Verwaltetes Produkt)

## Schritt 2: Produktdetails eingeben

1. **Produkt-ID**: Gib `com.pascalbieler.chatmate.premium` ein
   - Diese ID muss mit der in der App verwendeten ID übereinstimmen
   - Die ID kann nach der Erstellung nicht mehr geändert werden

2. **Name**: Gib "ChatMate Premium" ein
   - Dies ist der Name, der den Nutzern angezeigt wird

3. **Beschreibung**: Gib folgende Beschreibung ein:
   ```
   Schalte alle Premium-Funktionen frei: Bildaustausch, erweiterte Persönlichkeiten, Sprachnachrichten, thematische Hintergründe und mehr. Einmaliger Kauf, keine Abonnements.
   ```

4. **Preis**: Setze den Preis auf 3,99 €
   - Der Preis wird automatisch in andere Währungen umgerechnet

5. **Produkttyp**: Wähle "Nicht verbrauchbar" (Non-consumable)
   - Dies bedeutet, dass der Kauf dauerhaft ist und nicht erneuert werden muss

## Schritt 3: Länder und Regionen

1. Standardmäßig ist das Produkt in allen Ländern verfügbar, in denen die App verfügbar ist
2. Du kannst bestimmte Länder ausschließen, falls gewünscht
3. Für ChatMate empfehlen wir, das Produkt in allen Ländern verfügbar zu machen

## Schritt 4: Steuern und Compliance

1. Wähle die entsprechende Steuerkategorie: "Allgemein"
2. Bestätige, dass das Produkt keine Glücksspiel-Inhalte enthält
3. Bestätige, dass das Produkt keine Alkohol- oder Tabak-Inhalte enthält

## Schritt 5: Produkt speichern und aktivieren

1. Klicke auf "Speichern"
2. Überprüfe alle Informationen
3. Klicke auf "Aktivieren", um das Produkt zu veröffentlichen

## Schritt 6: Testen des In-App-Kaufs

### Testkonten einrichten

1. Gehe zu "Einstellungen" > "Lizenzprüfung"
2. Füge Testkonten hinzu (E-Mail-Adressen)
3. Diese Konten können In-App-Käufe testen, ohne tatsächlich zu bezahlen

### Testgeräte hinzufügen

1. Gehe zu "Einstellungen" > "Lizenzprüfung"
2. Füge die Geräte-IDs deiner Testgeräte hinzu
3. Diese Geräte können In-App-Käufe testen, ohne tatsächlich zu bezahlen

## Wichtige Hinweise

### Integration in der App

Die App verwendet bereits den folgenden Code zur Integration des In-App-Kaufs:

```dart
// In premium_service.dart
Future<bool> purchasePremium() async {
  // In-App-Kauf-Logik
  // Produkt-ID: com.pascalbieler.chatmate.premium
  // ...
}
```

### Steuerliche Informationen

- Du musst möglicherweise zusätzliche steuerliche Informationen in der Google Play Console angeben
- Dies hängt von deinem Wohnsitzland und den Ländern ab, in denen die App verfügbar ist

### Rückerstattungen

- Google verwaltet Rückerstattungen für In-App-Käufe
- Nutzer können innerhalb von 48 Stunden nach dem Kauf eine Rückerstattung beantragen

## Fehlerbehebung

### Problem: "In-App-Produkt kann nicht erstellt werden"
**Lösung:**
- Stelle sicher, dass ein Merchant-Konto verknüpft ist
- Überprüfe, ob die Produkt-ID einzigartig ist
- Stelle sicher, dass alle erforderlichen Felder ausgefüllt sind

### Problem: "In-App-Kauf funktioniert nicht in der App"
**Lösung:**
- Überprüfe, ob die Produkt-ID in der App mit der im Play Store übereinstimmt
- Stelle sicher, dass die App die Google Play Billing Library verwendet
- Teste mit einem Testkonto, um zu überprüfen, ob die Integration funktioniert

## Nächste Schritte

Nach der Einrichtung des In-App-Kaufs:
1. Teste den Kauf mit einem Testkonto
2. Überprüfe, ob die Premium-Funktionen nach dem Kauf freigeschaltet werden
3. Stelle sicher, dass der Kauf gespeichert wird und nach einer Neuinstallation der App erhalten bleibt

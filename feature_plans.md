# ChatMate - Neue Feature-Pläne

## 1. Charakterpersönlichkeiten

### Beschreibung
Füge verschiedene Persönlichkeitstypen hinzu, die das Antwortverhalten des KI-Charakters beeinflussen. Jede Persönlichkeit hat einen eigenen Kommunikationsstil, unabhängig vom emotionalen Zustand.

### Persönlichkeitstypen
1. **Schüchtern**
   - Zurückhaltende, vorsichtige Antworten
   - Verwendet mehr Fragezeichen und unsichere Formulierungen
   - Braucht länger, um Vertrauen aufzubauen
   - Typische Phrasen: "Ich bin mir nicht sicher...", "Vielleicht...", "Wenn es dir nichts ausmacht..."

2. **Selbstbewusst**
   - Direkte, bestimmte Antworten
   - Verwendet mehr Ausrufezeichen und starke Formulierungen
   - Schneller beim Aufbau von Vertrauen
   - Typische Phrasen: "Definitiv!", "Ich weiß genau...", "Natürlich!"

3. **Humorvoll**
   - Witzige, lockere Antworten
   - Verwendet mehr Emojis und Wortspiele
   - Emotionaler Zustand schwankt weniger stark
   - Typische Phrasen: "Haha!", "Das ist lustig!", "Kennst du den schon...?"

4. **Nachdenklich**
   - Tiefgründige, philosophische Antworten
   - Stellt Gegenfragen und reflektiert
   - Langsamer beim Aufbau von Vertrauen, aber stabiler
   - Typische Phrasen: "Ich denke darüber nach...", "Das erinnert mich an...", "Interessante Perspektive..."

### Implementierung
1. Erweitere das `Character`-Modell um einen `PersonalityType`-Enum
2. Aktualisiere den `AiService`, um Antworten basierend auf Persönlichkeit zu generieren
3. Füge Persönlichkeitsauswahl zum Charaktererstellungsbildschirm hinzu
4. Erstelle spezifische Antwortsets für jede Persönlichkeit

## 2. Stimmungs-Visualisierung

### Beschreibung
Visualisiere den emotionalen Zustand des KI-Charakters durch Emojis oder Farbindikatoren im Chat-Interface.

### Features
1. **Emoji-Indikator**
   - Zeigt ein Emoji neben dem Namen des Charakters an
   - Ändert sich basierend auf dem emotionalen Zustand
   - Beispiele: 😒 (distanziert), 😐 (neutral), 🙂 (nett), 😊 (interessiert)

2. **Farbverlauf**
   - Subtiler Farbverlauf im Hintergrund der Chat-Blasen
   - Rot/Grau für distanziert, Blau für neutral, Grün für nett, Pink/Lila für interessiert

3. **Stimmungsanzeige**
   - Kleine Anzeige oben im Chat-Fenster
   - Zeigt den aktuellen emotionalen Zustand an
   - Kann als Herz, Balken oder andere visuelle Metapher dargestellt werden

### Implementierung
1. Erstelle ein `MoodIndicator`-Widget für die Visualisierung
2. Integriere es in den Chat-Screen
3. Verbinde es mit dem emotionalen Zustand des Charakters
4. Füge Animationen für Übergänge zwischen Stimmungen hinzu

## 3. Minispiele im Chat

### Beschreibung
Füge kleine Spiele hinzu, die innerhalb des Chats gespielt werden können, um die Interaktion zu vertiefen und die Beziehung zu stärken.

### Spielideen
1. **Wahr oder Falsch**
   - Der Charakter stellt eine Aussage über sich selbst
   - Spieler muss raten, ob sie wahr oder falsch ist
   - Richtige Antworten verbessern die Beziehung

2. **Wortspiele**
   - Wortkettenspiel (letzter Buchstabe wird erster Buchstabe des nächsten Worts)
   - Assoziationsspiele
   - Reimspiele

3. **Persönlichkeitsquiz**
   - Kurze Fragen zur Persönlichkeit des Spielers
   - Der Charakter gibt Feedback und teilt eigene Präferenzen mit

4. **Rätsel und Geheimnisse**
   - Der Charakter gibt Rätsel auf
   - Mit der Zeit enthüllt der Charakter "Geheimnisse" über sich

### Implementierung
1. Erstelle ein `MiniGame`-System mit verschiedenen Spieltypen
2. Integriere Spieleinladungen in den Chat-Fluss
3. Implementiere Belohnungssystem für erfolgreiche Spiele
4. Speichere Spielergebnisse und -präferenzen

## 4. Tägliche Herausforderungen

### Beschreibung
Füge tägliche Herausforderungen oder Aufgaben hinzu, die der Spieler erfüllen kann, um die Beziehung zu verbessern und regelmäßiges Engagement zu fördern.

### Herausforderungstypen
1. **Gesprächsthemen**
   - Tägliches Thema zum Diskutieren
   - Charakter stellt Fragen zum Thema
   - Belohnung für tiefgehende Antworten

2. **Emotionale Aufgaben**
   - "Teile etwas, das dich heute glücklich gemacht hat"
   - "Erzähle von einer Herausforderung, die du gemeistert hast"
   - Fördert emotionale Bindung

3. **Kreative Aufgaben**
   - "Beschreibe einen perfekten Tag"
   - "Erfinde eine kurze Geschichte mit uns beiden"
   - Fördert Kreativität und Fantasie

4. **Streak-System**
   - Belohnungen für tägliches Einloggen
   - Spezielle Inhalte nach X Tagen Streak
   - Visuelle Anzeige des Fortschritts

### Implementierung
1. Erstelle ein `Challenge`-System mit verschiedenen Aufgabentypen
2. Implementiere einen täglichen Reset-Mechanismus
3. Füge Benachrichtigungen für neue Herausforderungen hinzu
4. Entwickle ein Belohnungssystem für abgeschlossene Herausforderungen

## 5. Erinnerungen und Kontext

### Beschreibung
Verbessere das Gedächtnis des KI-Charakters, damit er sich an frühere Gespräche erinnern und darauf Bezug nehmen kann.

### Features
1. **Wichtige Fakten merken**
   - Speichert vom Spieler geteilte persönliche Informationen
   - Bezieht sich später darauf (z.B. "Wie war dein Konzert gestern?")
   - Erstellt ein Gefühl von Kontinuität

2. **Gesprächsthemen-Gedächtnis**
   - Merkt sich, worüber bereits gesprochen wurde
   - Vermeidet Wiederholungen
   - Knüpft an frühere Gespräche an

3. **Jahrestage und besondere Daten**
   - Merkt sich, wann das Gespräch begann
   - Feiert "Beziehungs-Jahrestage"
   - Erwähnt, wie lange man sich schon kennt

### Implementierung
1. Erstelle ein `Memory`-System zur Speicherung wichtiger Informationen
2. Implementiere Algorithmen zur Extraktion relevanter Fakten aus Gesprächen
3. Entwickle ein System zur kontextbezogenen Einbindung von Erinnerungen
4. Speichere Zeitstempel für wichtige Ereignisse

## Priorisierung der Features

1. **Charakterpersönlichkeiten** - Höchste Priorität
   - Größter Einfluss auf das Spielerlebnis
   - Relativ einfach zu implementieren
   - Erhöht den Wiederspielwert erheblich

2. **Stimmungs-Visualisierung** - Hohe Priorität
   - Verbessert das Verständnis des emotionalen Systems
   - Bietet sofortiges visuelles Feedback
   - Technisch unkompliziert

3. **Erinnerungen und Kontext** - Mittlere Priorität
   - Schafft ein realistischeres Gesprächserlebnis
   - Erfordert sorgfältige Implementierung der Datenspeicherung

4. **Minispiele im Chat** - Mittlere Priorität
   - Fügt Abwechslung hinzu
   - Kann schrittweise implementiert werden

5. **Tägliche Herausforderungen** - Niedrigere Priorität
   - Gut für langfristiges Engagement
   - Erfordert Benachrichtigungssystem
   - Kann in späteren Updates hinzugefügt werden

# Tinyhouse Map

Eine SEO-optimierte, Wix-freundliche Leaflet-Karte für Smi´s Tiny House in Ebensee: 30 verifizierte Outdoor- und Kultur-POIs mit farbcodierten Stecknadeln, geprüften Koordinaten und keywordstarken Kurztexten. Unterkünfte sind bewusst ausgeschlossen.

## Nutzung & Wix-Einbettung

1. Öffne `smis-tinyhouse-map.html` (oder `index.html`) und kopiere den kompletten Inhalt in einen Wix-Custom-Code-/Embed-Block. Stelle 100 % Breite und mindestens 75vh Höhe ein.
2. Alternativ lade die Datei über die sichtbaren Buttons in der Seite herunter und füge sie in Wix hoch bzw. ein.
3. Lokale Vorschau: `./preview.sh` starten und `http://localhost:8080/index.html` öffnen (das Script versucht den Browser automatisch zu öffnen).
4. Kategorie-Buttons entsprechen den Pin-Farben, der Reset-Button hebt alle Filter auf. Der Home-Button setzt die Karte auf die Tiny-House-Koordinaten zurück.

## Vollständiger HTML-Download

- `smis-tinyhouse-map.html` ist identisch zur Startseite und kann direkt gespeichert/hochgeladen werden. Die Seite selbst zeigt im Header und rechts unten einen Download-CTA.

## Datenpflege

- POIs liegen im Array `pois` innerhalb der HTML-Datei und sind nach Kategorien mit Farbwerten organisiert.
- Bilder werden nur gesetzt, wenn sie eindeutig dem jeweiligen POI zugeordnet sind.
- Für SEO-Snippets der POIs kurze, keywordstarke Beschreibungen beibehalten und Koordinaten bei Änderungen verifizieren.

## Technologie

- [Leaflet](https://leafletjs.com/) für die Karte
- OpenStreetMap-Kacheln

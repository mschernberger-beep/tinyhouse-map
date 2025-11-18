<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Interaktive POI-Karte – Smi´s Tiny House / Ebensee</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
  <style>
    body { margin:0; font-family: Arial, sans-serif; background:#ffffff; }
    h2 { padding:10px; margin:0; color:#1a365d; font-size:24px; }
    #map { width:100%; height:70vh; border-radius:12px; position:relative; }
    #filters { padding:10px; background:#f0f4f8; display:flex; gap:10px; flex-wrap:wrap; border-bottom:2px solid #dce3eb; }
    .filter-btn { padding:6px 12px; background:#e2e8f0; border-radius:6px; cursor:pointer; border:1px solid #cbd5e1; font-size:14px; transition:0.2s; user-select:none; }
    .filter-btn.active { background:#1e40af; color:white; }
    #tiny-reset-btn { position:absolute; top:15px; right:15px; z-index:1000; background:white; border-radius:50%; width:48px;height:48px; display:flex; justify-content:center; align-items:center; box-shadow:0 2px 6px rgba(0,0,0,0.25); cursor:pointer; border:2px solid #1e40af; }
    #tiny-reset-btn:hover { background:#f0f0f0; }
    @media(max-width:768px){ #map{height:65vh;} h2{font-size:20px;} .filter-btn{font-size:12px;padding:4px 8px;} #tiny-reset-btn{width:42px;height:42px;} }
  </style>
</head>
<body>

<h2>Erkunden rund um Smi´s Tiny House – Ebensee</h2>
<div id="filters"></div>
<div id="map">
  <div id="tiny-reset-btn" title="Zurück zum Tiny House">
    <img src="https://cdn-icons-png.flaticon.com/512/3917/3917215.png" width="26" height="26" />
  </div>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
const Icons={tiny:new L.Icon({iconUrl:'https://cdn-icons-png.flaticon.com/512/3917/3917215.png',iconSize:[38,38],iconAnchor:[19,38]}),wandern:new L.Icon({iconUrl:'https://cdn-icons-png.flaticon.com/512/684/684908.png',iconSize:[32,32],iconAnchor:[16,32]}),see:new L.Icon({iconUrl:'https://cdn-icons-png.flaticon.com/512/427/427735.png',iconSize:[32,32],iconAnchor:[16,32]}),essen:new L.Icon({iconUrl:'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',iconSize:[32,32],iconAnchor:[16,32]}),kultur:new L.Icon({iconUrl:'https://cdn-icons-png.flaticon.com/512/3448/3448636.png',iconSize:[32,32],iconAnchor:[16,32]}),sport:new L.Icon({iconUrl:'https://cdn-icons-png.flaticon.com/512/854/854878.png',iconSize:[32,32],iconAnchor:[16,32]})};

const tinyHouse={lat:47.792130,lng:13.760837,name:"Smi´s Tiny House",cats:["Tiny House"],desc:"Dein gemütliches Tiny House.",img:"https://raw.githubusercontent.com/mschernberger-beep/tinyhouse-map/main/1-Aussenansicht.png",link:"https://www.smis-tiny-house.com",icon:Icons.tiny,isTiny:true};

const pois=[tinyHouse,{lat:47.814208,lng:13.762970,name:"Gasthaus Roitner",cats:["Essen"],desc:"Österreichische Küche.",img:"https://upload.wikimedia.org/wikipedia/commons/6/60/Gasthof.jpg",link:"https://traunsee-almtal.salzkammergut.at/oesterreich-gastronomie/detail/430000628/gasthof-roitner.html",icon:Icons.essen},{lat:47.8069,lng:13.7709,name:"THE RIVERWAVE",cats:["Sport"],desc:"Künstliche Surfwelle.",img:"https://upload.wikimedia.org/wikipedia/commons/6/6b/Eisbach_surfer.jpg",link:"https://www.theriverwave.com",icon:Icons.sport},{lat:47.80936,lng:13.78999,name:"Strandbad Rindbach",cats:["See"],desc:"Baden am Traunsee.",img:"https://upload.wikimedia.org/wikipedia/commons/3/3c/Traunsee.jpg",link:"https://www.ebensee.at",icon:Icons.see},{lat:47.803127,lng:13.797915,name:"Rindbach Wasserfall",cats:["Wandern"],desc:"Schöner Wasserfall.",img:"https://upload.wikimedia.org/wikipedia/commons/4/49/Waterfall.jpg",link:"https://de.wikipedia.org/wiki/Rindbachfälle",icon:Icons.wandern},{lat:47.813056,lng:13.758333,name:"Feuerkogel Talstation",cats:["Wandern"],desc:"Seilbahn zum Feuerkogel.",img:"https://upload.wikimedia.org/wikipedia/commons/1/14/Cablecar.jpg",link:"https://www.feuerkogel.info",icon:Icons.wandern},{lat:47.8345,lng:13.6889,name:"Langbathseen",cats:["See","Wandern"],desc:"Glasklare Seen.",img:"https://upload.wikimedia.org/wikipedia/commons/9/9a/Langbathseen.jpg",link:"https://de.wikipedia.org/wiki/Langbathseen",icon:Icons.see},{lat:47.8332,lng:13.689,name:"Hochsteinalm",cats:["Wandern"],desc:"Almhütte mit Aussicht.",img:"https://upload.wikimedia.org/wikipedia/commons/1/1f/Alm.jpg",link:"https://www.salzkammergut.at",icon:Icons.wandern},{lat:47.8289,lng:13.7853,name:"Kleiner Sonnstein",cats:["Wandern"],desc:"Beliebter Gipfel.",img:"https://upload.wikimedia.org/wikipedia/commons/0/08/Kleiner_Sonnstein.jpg",link:"https://de.wikipedia.org/wiki/Kleiner_Sonnstein",icon:Icons.wandern},{lat:47.8239,lng:13.7742,name:"Großer Sonnstein",cats:["Wandern"],desc:"Gipfel über Ebensee.",img:"https://upload.wikimedia.org/wikipedia/commons/1/1b/Grosser_Sonnstein.jpg",link:"https://de.wikipedia.org/wiki/Großer_Sonnstein",icon:Icons.wandern},{lat:47.815,lng:13.7764,name:"Traunsee Radweg Einstieg",cats:["Radfahren"],desc:"Seen-Radtour.",img:"https://upload.wikimedia.org/wikipedia/commons/3/3c/Cycling_path.jpg",link:"https://www.dastraunsee.at",icon:Icons.sport},{lat:47.8135,lng:13.76,name:"MTB Route Wildkogler",cats:["Mountainbike"],desc:"Mountainbike-Strecke.",img:"https://upload.wikimedia.org/wikipedia/commons/8/8c/Mountainbike.jpg",link:"https://traunsee-almtal.salzkammergut.at",icon:Icons.sport}];

const wanderwege=[L.polyline([[47.813056,13.758333],[47.8239,13.7742],[47.8289,13.7853]],{color:'#1e90ff',weight:4}),L.polyline([[47.80936,13.78999],[47.803127,13.797915]],{color:'#228B22',weight:4})];
const radwege=[L.polyline([[47.79213,13.760837],[47.805,13.769],[47.80936,13.78999]],{color:'#ff8c00',dashArray:'6,6',weight:4})];

const map=L.map('map').setView([47.806,13.775],13);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{attribution:'© OpenStreetMap'}).addTo(map);
let markerLayer=L.layerGroup().addTo(map);let lineLayer=L.layerGroup().addTo(map);

const categorySet=new Set();pois.forEach(p=>p.cats.forEach(c=>{if(c!=="Tiny House")categorySet.add(c);}));const categories=Array.from(categorySet).sort();

const filterDiv=document.getElementById('filters');let activeCats=[];
const allBtn=document.createElement('div');allBtn.className='filter-btn active';allBtn.textContent='Alle Aktivitäten';allBtn.onclick=()=>{activeCats=[];
# tinyhouse-map
Interaktive Karte rund um Smi´s Tiny House

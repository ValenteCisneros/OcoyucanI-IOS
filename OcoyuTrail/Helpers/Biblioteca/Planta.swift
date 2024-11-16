//
//  Planta.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 14/11/24.
//

import Foundation

struct Planta: Identifiable {
    let id: Int
    let nombre: String
    let informacion: String
    let categoria: String
}

class PlantaData {
    static let plantas: [Planta] = [
        Planta(
            id: 1,
            nombre: "Sida abutifolia",
            informacion: "Una planta herbácea común en áreas tropicales y subtropicales, conocida por sus pequeñas flores amarillas y su uso medicinal en algunas culturas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 2,
            nombre: "Lysiloma acapulcensis",
            informacion: "Un árbol que se encuentra en áreas tropicales de México. Es usado en reforestación y su madera en carpintería.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 3,
            nombre: "Acacia acatlensis",
            informacion: "Esta acacia es nativa de México y crece en zonas áridas y semiáridas. Su nombre común se debe a que se utiliza para forraje de animales.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 4,
            nombre: "Lantana achyranthifolia",
            informacion: "Una planta arbustiva con flores coloridas, generalmente de color rosa, amarillo o rojo. Es resistente y crece en áreas secas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 5,
            nombre: "Plumería acutifolia",
            informacion: "Es famosa por sus flores fragantes y atractivas, comúnmente vistas en jardines. En algunas culturas, sus flores se usan en coronas o collares.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 6,
            nombre: "Ceiba aesculifolia",
            informacion: "Este árbol de gran tamaño es característico por sus espinas en el tronco. Sus fibras se usan tradicionalmente para hacer rellenos de almohadas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 7,
            nombre: "Conopholis alpina",
            informacion: "Planta parasitaria que se encuentra en áreas montañosas, alimentándose de las raíces de otras plantas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 8,
            nombre: "Chenopodium ambrosioides",
            informacion: "Mejor conocida como epazote, es utilizada principalmente como hierba medicinal y condimento en la cocina mexicana.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 9,
            nombre: "Solanum americanum",
            informacion: "Un arbusto que produce pequeñas bayas negras. Algunas partes de la planta pueden ser tóxicas si se consumen en grandes cantidades.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 10,
            nombre: "Simsia amplexicaulis",
            informacion: "Es una planta de la familia de las margaritas, común en terrenos baldíos o zonas perturbadas. Sus flores amarillas y hojas abrazadoras son características.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 11,
            nombre: "Pseudosmodingium andreux",
            informacion: "Un árbol conocido por sus propiedades medicinales y su uso en la reforestación de zonas áridas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 12,
            nombre: "Agave angustifolia",
            informacion: "Es el maguey más comúnmente usado en la producción de mezcal. También se utiliza en medicina tradicional y como planta ornamental.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 13,
            nombre: "Malvaviscus arboreus",
            informacion: "Un arbusto con flores rojas brillantes, usado tradicionalmente en el tratamiento de problemas respiratorios.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 14,
            nombre: "Anagallis arvensis",
            informacion: "Planta herbácea de pequeñas flores rojas o azules, empleada en la medicina popular para tratar infecciones.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 15,
            nombre: "Bidens aurea",
            informacion: "Planta con propiedades medicinales, usada principalmente para problemas digestivos. Sus flores amarillas son llamativas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 16,
            nombre: "Dalea bicolor",
            informacion: "Planta de la familia Fabaceae, con flores coloridas que atraen a polinizadores, usada ornamentalmente en zonas áridas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 17,
            nombre: "Acacia bilimekii",
            informacion: "Conocida como 'Mushel espinoso', esta acacia se usa en cercos vivos y reforestación. Crece en climas semiáridos.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 18,
            nombre: "Glandularia bipinnatifida",
            informacion: "Planta con flores purpúreas o rosadas, nativa de áreas áridas y comúnmente llamada 'Alfombrilla de campo'.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 19,
            nombre: "Cosmos bipinnatus",
            informacion: "Conocido como 'Girasol morado', es una planta ornamental que atrae polinizadores y se adapta bien a suelos pobres.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 20,
            nombre: "Salix bonplandiana",
            informacion: "También llamado 'Sauce llorón', se usa en reforestación y control de erosión en zonas ribereñas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 21,
            nombre: "Psilactis brevilingulata",
            informacion: "Es una planta con flores de tonos violetas, generalmente se encuentra en áreas desérticas. Tiene propiedades medicinales.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 22,
            nombre: "Cologania broussoneti",
            informacion: "Es una planta perenne que se desarrolla en climas templados. Pertenece a la familia de las leguminosas, y sus flores suelen ser rosadas o moradas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 23,
            nombre: "Psittacanthus calyculatus",
            informacion: "Un muérdago que se encuentra comúnmente en árboles como encinos y pinos, produciendo flores rojas. Es una planta hemiparásita.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 24,
            nombre: "Lantana camara",
            informacion: "Conocida por sus flores de colores vibrantes, es una planta invasora en algunas regiones. También se usa en medicina tradicional.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 25,
            nombre: "Conyza canadensis",
            informacion: "Una planta herbácea que se caracteriza por sus pequeños capítulos florales. Es considerada maleza en muchos cultivos.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 26,
            nombre: "Sideroxylon capiri",
            informacion: "Árbol conocido como tempisque, puede alcanzar los 35 metros. Sus frutos en forma de baya son comestibles cuando están maduros.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 27,
            nombre: "Prunus capuli",
            informacion: "El capulín es un árbol frutal, cuyas bayas oscuras son comestibles y utilizadas en gastronomía.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 28,
            nombre: "Alternanthera caracasana",
            informacion: "Planta herbácea con propiedades medicinales, usada comúnmente en remedios para tratar infecciones.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 29,
            nombre: "Eryngium carlinae",
            informacion: "Conocida como cardo, esta planta de flores espinosas es común en áreas montañosas. Tiene uso ornamental y medicinal.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 30,
            nombre: "Quercus castanea",
            informacion: "Un tipo de encino que crece en zonas templadas, apreciado por su madera dura.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 31,
            nombre: "Celtis caudata",
            informacion: "Árbol o arbusto conocido por su madera resistente. Crece en diversas regiones de México, preferentemente en climas cálidos y secos.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 32,
            nombre: "Lepechinia caulescens",
            informacion: "Planta aromática de la familia de las Lamiaceae. Se encuentra en bosques montañosos de México y se usa tradicionalmente en infusiones.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 33,
            nombre: "Annona cherimola",
            informacion: "Fruto tropical de sabor dulce, originario de América, especialmente cultivado en climas cálidos. Es valorada por su pulpa comestible.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 34,
            nombre: "Rhus chondroloma",
            informacion: "Planta del género Rhus, caracterizada por sus hojas compuestas y su presencia en zonas áridas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 35,
            nombre: "Erodium cicutarium",
            informacion: "Conocido como 'alfilerillo', es una hierba común en campos y pastizales. Tiene pequeñas flores de color púrpura o rosa.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 36,
            nombre: "Boerhavia coccinea",
            informacion: "Planta rastrera que crece en suelos secos. Sus flores rosadas y su capacidad de resistir climas extremos la hacen distintiva.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 37,
            nombre: "Phaseolus coccineus",
            informacion: "Especie de frijol de flores rojas, común en regiones altas de México, utilizado tanto para alimento como para forraje.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 38,
            nombre: "Acacia cochliacantha",
            informacion: "Arbusto espinoso que crece en zonas secas de México. Sus semillas se utilizan a veces en la medicina tradicional.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 39,
            nombre: "Baccharis conferta",
            informacion: "Arbusto perenne que se encuentra en zonas montañosas de México. Sus flores amarillas lo hacen fácil de identificar.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 40,
            nombre: "Melochia corymbosa",
            informacion: "Planta que crece en suelos húmedos y se reconoce por sus pequeñas flores en racimos.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 41,
            nombre: "Ageratum corymbosum",
            informacion: "Planta herbácea nativa, común en áreas perturbadas. Se usa para controlar la erosión y a veces en medicina tradicional para tratar heridas.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 42,
            nombre: "Ficus cotinifolia",
            informacion: "Árbol que puede alcanzar hasta 30 metros de altura. Tiene raíces aéreas características y es importante en la regeneración de ecosistemas, además de tener uso ornamental.",
            categoria: "DICOTYLEDONAE"
        ),
        Planta(
            id: 43,
            nombre: "Rumex crispus",
            informacion: "Planta herbácea conocida por sus hojas alargadas y uso medicinal. Es nativa de Eurasia pero también se encuentra en México. Ayuda a tratar trastornos digestivos.",
            categoria: "DICOTYLEDONAE"
        ),


        
    ]
    
    static func getAllPlantas() -> [Planta] {
        return plantas
    }
    
    static func getPlanta(byId id: Int) -> Planta? {
        return plantas.first { $0.id == id }
    }
}

extends Node

var CITAS = ["La guerra es la continuación de la política por otros medios. General Carl von Clausewitz",
"La patata no se puede poseer, la patata es un fruto de la nave naturaleza. Homer Simpson",
"Tenemos que fabricar máquinas que nos permitan seguir fabricando máquinas, porque lo que va a hacer nunca una máquina es fabricar máquinas. Mariano Rajoy",
"La historia será amable conmigo, porque tengo intención de escribirla. Winston Churchill",
"Las victorias auténticas y duraderas son las de la paz, no las de la guerra. Ralph Waldo Emerson",
"Nos pocos, nos felices pocos, nos banda de hermanos, porque aquel que vierta su sangre conmigo será mi hermano. William Shakespeare, Enrique V",
"Vivid como hombres valientes; y si la fortuna os es adversa, afrontad sus reveses con valentía. Cicerón",
"El valor y la perseverancia tienen un talismán mágico, ante el que las dificultades desaparecen y los obstáculos se desvanecen en el aire. John Quincy Adams",
"El valor significa estar muerto de miedo, pero actuar igualmente. John Wayne",
"Sobre todo, jamás os asustéis. El enemigo que os obliga a retiraros también está asustado de vosotros en ese preciso momento. André Maurois",
"Una única cosa le he pedido a Dios, una nimiedad: Oh, Señor, haz ridículos a mis enemigos. Y Dios me la concedió. Voltaire",
"Conquista el que resiste. Persio",
"Mejor morir de pie que vivir de rodillas. Emiliano Zapata",
"Aquellos que disfrutan mucho tiempo de privilegios como los que disfrutamos nosotros, acaban olvidando con el tiempo que para ganarlos tuvieron que morir hombres. Franklin D. Roosevelt",
"La guerra es una serie de catástrofes que desembocan en la victoria. Georges Clemenceau",
"Jamás ha habido una buena guerra o una mala paz. Benjamin Franklin",
"En la guerra, ganas o pierdes, vives o mueres, y la diferencia es solo de una pestaña. General Douglas MacArthur",
"Que Dios se apiade de mis enemigos, porque yo no lo haré. General George S. Patton",
"En la guerra moderna... mueres como un perro sin motivo alguno. Ernest Hemingway",
"Está mal hacer cosas malas. Por eso has muerto. Alafeliz",
"Si quieres la paz, prepárate para la guerra. Flavio Vegecio",
"La auténtica guerra jamás llega a los libros. Walt Whitman",
"La guerra es miedo enmascarado de valor. General William C. Westmoreland",
"Todo lo que la maldad necesita para triunfar es que los hombres buenos no hagan nada. Edmund Burke",
"Es bueno que la guerra sea algo tan temible, o podría acabar gustándonos. Robert E. Lee",
"De mi cuerpo descompuesto crecerán las flores, y yo estaré en ellas. Eso es eternidad. Edvard Munch",
"Aquel al que le va bien en la guerra se gana el derecho de empezar a que le vaya bien en la paz. Robert Browning",
"La guerra se terminaría si los muertos pudieran regresar. Stanley Baldwin",
"No puede decirse que la civilización no progresa, pues en cada guerra se encuentran nuevas formas de matar. Will Rogers",
"En la paz los hijos entierran a sus padres, pero en la guerra los padres entierran a sus hijos. Heródoto",
"Hacemos la guerra para poder vivir en paz. Aristóteles",
"La forma más rápida de terminar una guerra es perderla. George Orwell",
"El único ganador de la guerra de 1812 fue Tchaikovsky. Solomon Short",
"La guerra es cruel y no se puede pulir. William Tecumseh Sherman",
"En la guerra, ningún soldado sale ileso. José Narosky",
"Si conoces al enemigo y te conoces a ti mismo, no debes temer el resultado de un centenar de batallas. Sun-Tzu",
"El nuestro es un mundo de gigantes nucleares e infantes éticos. Sabemos más de la guerra que de la paz, de matar que de vivir. General Omar Bradley",
"Los hombres viejos declaran las guerras, pero son los jóvenes las que las luchas y los que mueren. Herbert Hoover",
"La guerra es deliciosa para aquellos que no la han experimentado. Erasmo de Rotterdam",
"La guerra no determina quien tiene razón, sólo quien queda. Bertrand Russell",
"Aquel que tiene mil amigos, no le sobra ni uno. Aquel que tiene un enemigo, lo encontrará en todas partes. Ali ibn-Abi-Talib",
"Solo los muertos ven el fin de la guerra. Platon",
"Mientras haya hombres habrá guerras. Albert Einstein",
"Todas las guerras son guerras civiles, porque todos los hombres son iguales. Francois Fenelon",
"No hay manera honorable de matar, no hay manera gentil de destruir. No hay nada bueno en la guerra, excepto que se acaba Abraham Lincoln",
"Aquel que teme ser conquistado es seguro que será derrotado. Napoleón Bonaparte",
"Nunca he abogado por la guerra, excepto como medio de paz. Ulysses S. Grant",
"En el ejército soviético hace falta más valor para retirarse que para avanzar. Joseph Stalin",
"Si no terminamos con la guerra, la guerra terminará con nosotros. H. G. Wells",
"Los Cylons fueron creados por el hombre. Evolucionaron. Se rebelaron. Existen muchas copias. Y tienen un Plan. Galáctica",
"En el juego de tronos o ganas o mueres. Cersei Lannister",
"Ahora, me he convertido en la muerte, destructora de mundos. Vishnu",
"¿Carlos, no oyes un ruidito?. Luis Moya",
"Al pan, pan y al vino, vino. Martin Lutero",
"¡Soy Felinor! ¿No me reconoces? . Felinor",
"No hay nada malo en que un hombre use cremas faciales en todo el cuerpo. Pedro Sánchez",
"No pienso gastar más de 7 minutos en limpiar. Juan Pedro Cascales",
"No es necesario creer en Dios para ser una buena persona. Papa Francisco",
"La Brassica oleracea italica, brécol, bróquil, bróculi o brócoli, del latín brachium «brazo» (a través del italiano broccoli), es una planta de la familia de las brasicáceas, antes llamadas crucíferas. Enciclopedia Galáctica",
"La papa o patata (Solanum tuberosum) es una especie de planta herbácea perteneciente al género Solanum de la familia de las solanáceas, es originaria de la región que hoy comprendería al altiplano sur del Perú1 y al noroeste de Bolivia. Enciclopedia Galáctica",
"La papa cultivada fue vista por primera vez por los españoles en el valle de la Grita, en la provincia de Vélez (Colombia) en 1537. Así fue relatado por el conquistador, cronista e historiador español Pedro Cieza de León en su obra Crónica del Perú publicada en Sevilla en 1553, quien además añadió que él mismo la vio en Quito (Ecuador), así como en Popayán y  Pasto (Colombia). Enciclopedia Galáctica",
"El brócoli tiene un alto contenido en vitamina C y fibra alimentaria; también contiene múltiples nutrientes con potentes propiedades anti-cancerígenas, como diindolilmetano y  pequeñas cantidades de selenio.1​ Una sola ración proporciona más de 30 mg de vitamina C y media-taza proporciona 52 mg. Enciclopedia Galáctica"]

var RECETA = "Ingredientes: Medio kilo de brócoli verde, 1 patata, 3 dientes de ajo, 1 cucharadita de pimentón dulce, 1 cucharadita de vinagre de vino blanco, Aceite de oliva virgen extra, Sal, Elaboracion, Limpiamos el brócoli y lo separamos en arbolitos. Pelamos la patata, la lavamos y la troceamos gruesa. Cocemos la patata con el brócoli al vapor o en muy poca agua con sal con la cazuela tapada. 7 minutos. La verdura debe quedar tierna pero entera. La escurrimos muy bien sobre un colador ara que suelte toda el agua. Mientras tanto pelamos los ajos y los fileteamos. Los doramos al fuego en aceite de oliva. Cuando empiecen a tomar color añadimos el pimentón, removemos un momento para que ligue bien con el aceite y retiramos del fuego. Ya fuera del fuego añadimos el vinagre y la sal. Regamos la verdura caliente con este adobo y servimos al momento."

func _ready():
	set_process_input(true)
	var texto
	var result
	if(State.win):
		result = "SUCCESS!"
		texto = RECETA
	else:
		randomize()
		var index = (randi() % CITAS.size())
		result = "FAILURE!"
		texto = CITAS[index]
	get_node("Result").set_text(result)
	get_node("Quote").set_text(texto)

func _input(event):
	if(event.is_action_pressed("reload")):
		State.change_scene("res://scenes/InGame.tscn")
	elif(event.is_action_pressed("exit")):
		get_tree().quit()
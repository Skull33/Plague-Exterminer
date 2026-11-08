<h1 align = "center">Plague Exterminer</h1>

<p align = "left"> 
    $\color{red}{\text{SI ENCONTRASTE ESTE PROYECTO ESPERO QUE MI JUEGO TE HAYA GUSTADO}}$<br>
    Se que esto parece un blog personal pero es el proceso completo de como desarrolle este juego
</p><br>

# Plague Exterminer (GAME DESIGN DOCUMENT)
Desarrollador único: Alonzo Estéfano Cuela Rodríguez (Dnur)<br>
## Idea del juego
Esta idea nacio para ser el primer videojuego de SkullStudios<br>
nació como idea de muchisimos prototipos lost media que hice antes,<br>
sin la más remota idea de que hacia, ahora tengo una idea más clara. <br><br>
<h1 align = "center">$\color{red}{\text{Hacer el juego más gore y visceral que se me haya ocurrido.}}$</h1><br>
<br>

## Ideas pasadas
Jaja pues aqui te relatare el proceso de como nacio este proyecto,<br> 
si quieres leer la documentacion de lo demás, puede saltarte esta parte<br>
es algo larga

LISTA DE INTENTOS PASADOS

1. UNSLAYED DEATH (la idea original):<br>
    <p>
    Pues todo esto nace de la idea de programar juego, como cualquiera<br>
    que guste de este arte, tenia unos quince o dieciseis, cuando se me<br>
    ocurrio unir varias de mis franquicias favoritas, en ese momento de mi vida<br>
    juegos como: DOOM, Left 4 Dead 2, etc.<br><br>
    <img src="img_readme/doom.png">
    <br><br>
    Queria hacer una especie de mundo abierto con zombies, un estilo de comic con<br>
    graficos como en DOOM, mas no tenia los conocimientos sobre programacion ni<br>
    idea de como empezar.<br>
    Puedes encontrar las viejas publicaciones en: <a href="https://www.instagram.com/skullstds/" style="color: #ff00d4; font-weight: bold;"> Mi Instagram</a><br>
    </p>
2. THERE'S NO TIME TO CRY (el aprendizaje):<br>
    <p>
    Bueno, aunque en el texto plano parece que la idea anterior muto a el <br>
    juego presente, de hecho; esta idea surgio entre 2023 en adelante.<br><br>
    Si, UNSLAYED DEATH quedó cancelado, o bueno eso parecia, ya entrando<br>
    en la universidad, pues lleve un curso sobre desarrollo de videojuegos,<br>
    aunque era más publicidad que otra cosa, aprendí a programar de verdad y<br>
    más importante hice un prototipo que mis compañeros vieron, se llamaba<br>
    "THERE'S NO TIME TO CRY".<br><br>
    <img src="img_readme/tnttc.png" alt="sprites del protagonista y enemigos del juego">
    Debo admitir que el nombre suena como canción depresiva de los años 2000-2009<br>
    pero eran mis primeros esbozos en el mundillo del desarrollo.<br><br>
    El juego consistia en una bolita que se movia en un entorno TOP-DOWN (vista desde arriba)<br>
    tu misión era muy simple, unicamente tenias que recoger una llaves que estaban en las 4 esquinas<br>
    de la ventana, más los zombies aparecian en cualquier punto del mapa y te mataban al instante de<br>
    entrar en contacto con el jugador.<br>
    $\color{green}{\text{RECUERDO QUE LOS SPRITES DE LOS ZOMBIES TEMBLABAN AL COLISIONAR CON EL JUGADOR}}$<br>
    </p>
3. PLAGUE EXTERMINER PARTE 1 (el surgimiento e ideas viejas):<br>
    <p>
    Esta es la etapa mas cercana a este documento, surgio cerca del 2024, cuando estabá muy frustrado<br>
    al no poder encontrar una idea para un juego y todas las que se me ocurrian pues las descartaba, culpando<br>
    a mi incapacidad y falta de talento, esas voces que muchas veces detienen a los grandes creadores de cumplir<br>
    sus metas, eran como una plaga que habitaba en mi cabeza, tomandolas como inspiracion decidi tomar las plagas<br>
    como tema para mi juego.<br><br>
    - El inicio del desarrollo:<br>
        <p>
        Empece seleccionando el editor que me ayudaria en esta misión, lo que no sabia<br>
        es que ese era uno de los pasos mas dificiles cuando empiezas como desarrollador<br>
        surgen un montón de dudas, cosas como:
        - ¿Qué motor es mejor?
        - ¿Servirá para mi proyecto?
        Si, son dudas muy comunes pero la respuesta rápida es, UTILIZA CUALQUIER EDITOR.<br>
        Si aprendes a utilizarlo bien y lo entiendes, no hay limites para lo demás.
        </p>
    - Una trama enredada:<br>
        <p>
        Pues, pasando del problema que fue seleccionar el editor, termine optando por GODOT<br><br>
        <img src="img_readme/godot.png"><br><br>
        De hecho ya lo conocia de un prototio anterior, aunque en su versión 3.X, actualmente utilizo<br>
        la 4.X, el nuevo problema (y futuro  $\color{red}{\text{ERROR}}$), fue empezar por buscar una trama<br>
        crear un protagonista (o intentarlo por lo menos), y empece armando un prototipo, al estilo de DOOM,<br>
        disponible en itch.io si deseas probarlo<br>
        <a href="https://skullstds.itch.io/plague-exterminer" style="color: #792d2dbe; font-weight: bold;"> PLAGUE EXTERMINER (OLD VERSIONS)</a><br>
        la primera idea de trama era sobre un veterano de guerra, abandonado por la vida donde un personaje extraño (EL CONTRATADOR), lo convoca y lo<br> 
        contrata como exterminador de plagas, sin embargo; la escena inicial se corrompio, eso me llevo a abandonar el proyecto unos meses.<br><br>
        Afortunadamente tambien estaba trabajando en la escena siguiente odne planeaba que al estilo de Hotline Miami<br><br>
        <img src="img_readme/hotline.png"><br><br>
        recibieras llamadas de desconocidos para empezar tus misiones.<br>
        Como puedes notar esa idea no prevalecio, de ella conserve ese segundo escenario que se convertiria en el principal<br>
        (UN HOTEL) donde la trama paso a que este veterano fue secuestrado por una empresa malévola, y el jugador se encontraba<br>
        en una trama donde estaba siendo entrenado para ser el villano, dandole un buen PLOT TWIST a la trama,<br>
        en ese proceso dibuje los sprites del primer enemigo una RATA MUTANTE.<br><br>
        <img src="img_readme/rata_mutante1.png" alt = "rata mutante enemigo basico de Plague Exterminer"><br><br>
        Y esta trama tampoco se mantuvo, lo unico que cambió, fue que el protagonista ya no sería el veterano de guerra,<br>
        sino que seria un sicario, que habia ido a encargarse de un capo de la mafia, pero la plaga de ratas primigenia, coincidio<br>
        en su imvasión a la superficie.<br><br>
        En esta parte del desarrollo diseñe otras entidades que atacarian al jugador<br><br>
        <img src="img_readme/saco_humano.png" alt = "Saco de piel humano relleno de ratas pequeñas que disparaba una rafaga de balas"><br>
        <img src="img_readme/mini_rata.png" alt = "rata diminuta que es parte del rellano del saco humano su función era escapar del jugador a menos que este se encuentre cerca, en ese caso saltaban ajugador y explotaban en su cara"><br><br>
        Tuve otra idea donde la plaga era como un virus de computadora al estilo PONY ISLAND, vivias una aventura donde el juego estaba corrupto.<br>
        Y tal y como te imaginarás esa idea también quedo descartada, a este paso sabia que la trama se me escapaba de las manos y ue desviaba muchos<br>
        recursos del proyecto sin hacer avances reales, entre en la misma etapa de estancamineto que me haiba llevado a desarrollar este juego.<br><br>
        Salvo que algo cambio está vez, ahora no me sentia incapaz, sino que me importaba tanto elproyecto que olvide hacer las pruebas en Gray Box,<br>
        pruebas escenciales para saber que era lo que queria realmente del juego.<br>
        </p>
    </p>
4. PLAGUE EXTERMINER PARTE 2 (un reinicio forzosamente necesario):<br>
    <p>
    
    </p>
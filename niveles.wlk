import wollok.game.*
import mario.*
import extras.*
import enemigos.*

object juego {

  method iniciar() {

    game.addVisual(donkeyKong)
    //game.addVisualCharacter(mario)
    game.onTick(2500, "genera mas proyectiles", { donkeyKong.lanzarProyectil() }) //va lenteja el juego, denle la letal a wollok

    game.onTick(2500, "se mueve la mona", { donkeyKong.aparecerAleatorio() })

    game.addVisual(mario)

    //game.addVisual(princesaPeach) //encontrar una mas grande (?)

    marioVidas.vidas().forEach{vida => game.addVisual(vida)} //las vidas son una coleccion. En distintos niveles pueden cambiar las vidas. Segun el nivel, podemos sacar la ultima vida en la lista para reducir las vidas, y sigue funcando
    
    //game.addVisual(plataforma)

    config.configurarTeclas()

    config.configurarColisiones()

  }

  method terminar(){
    game.schedule(1000, {game.stop()})
  }

}


object config {

  method configurarTeclas() {
    
    keyboard.a().onPressDo({mario.mover(mario.position().left(1))})
    
		keyboard.d().onPressDo({mario.mover(mario.position().right(1))})

    keyboard.w().onPressDo({mario.mover(mario.position().up(1))})
    
		keyboard.s().onPressDo({mario.mover(mario.position().down(1))})

    keyboard.left().onPressDo({ mario.mover(mario.position().left(1)) })
    
		keyboard.right().onPressDo({mario.mover(mario.position().right(1))})

    //keyboard.space().onPressDo({mario.saltar()})

  }

  method configurarColisiones() {  // con peach y fuegos, faltan plataformas y posicionar los personajes y algo para ganar score

    game.onCollideDo(mario, {algo => algo.manosiadoPorMario()})

  }

}
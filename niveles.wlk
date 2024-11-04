import wollok.game.*
import mario.*
import items.*
import enemigos.*

object juego {
  var property dificultad = 1 //SIN USAR TODAVÍA

  method iniciar() {

    config.configurarTeclas()
    config.configurarColisiones()
    
    game.addVisual(kongiDonk)
    game.addVisual(mario)

    game.addVisual(moneda_inherte)
    game.addVisual(contador_moneda)


    marioVidas.inicializarVidas()

    game.onTick(500, "genera mas proyectiles", { kongiDonk.lanzarProyectil() })

    game.onTick(200, "se mueve la mona", { kongiDonk.mover() })

    game.onTick(200, "movimiento proyectil", {kongiDonk.moverProyectiles()})

    game.onTick(2000, "generarMoneda", { generadorDeObjetos.generarMoneda() }) // Genera una moneda cada 2 segundos
  }

  method terminar(){
    game.sound("levelcomplete.wav").play()
    game.schedule(1000, {game.stop()})
  }

}

object config {

  method configurarTeclas() {
    
    keyboard.a().onPressDo({mario.mover(mario.position().left(1))})
		keyboard.d().onPressDo({mario.mover(mario.position().right(1))})
    keyboard.w().onPressDo({mario.mover(mario.position().up(1))})
		keyboard.s().onPressDo({mario.mover(mario.position().down(1))})

  }

  method configurarColisiones() {
    game.onCollideDo(mario, {algo => algo.manosiadoPorMario()})
  }

}
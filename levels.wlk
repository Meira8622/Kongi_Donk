import wollok.game.*
import mario.*
import items.*
import enemigos.*

object juego {

  method iniciar() {
    game.addVisual(mario)
    game.addVisual(kongiDonk)

    config.configurarTeclas()
    config.confiurarEnemigo()
  }

}

object config {

  method configurarTeclas() {
    
    keyboard.a().onPressDo({mario.mover(mario.position().left(1))})
		keyboard.d().onPressDo({mario.mover(mario.position().right(1))})
    keyboard.w().onPressDo({mario.mover(mario.position().up(1))})
		keyboard.s().onPressDo({mario.mover(mario.position().down(1))})
  
  }

  method confiurarEnemigo() {
    game.onTick(250, "KongiDonk Position", { kongiDonk.mover() })
  }


}

// object juego {
  
//   method iniciar() {

//     game.addVisual(donkeyKong)

//     game.addVisual(mario)

//     marioVidas.inicializarVidas()

//     game.onTick(200, "genera mas proyectiles", { donkeyKong.lanzarProyectil() })

//     game.onTick(200, "se mueve la mona", { donkeyKong.aparecerAleatorio() })

//     game.onTick(200, "movimiento proyectil", {donkeyKong.moverProyectiles()})

//     game.onTick(2000, "generarMoneda", { generadorDeObjetos.generarMoneda() }) // Genera una moneda cada 2 segundos
    
//     config.configurarTeclas()

//     config.configurarColisiones()

//   }

//   method terminar(){
//     game.schedule(1000, {game.stop()})
//   }
// }

// object config {

//   method configurarTeclas() {
    
//     keyboard.a().onPressDo({mario.mover(mario.position().left(1))})
    
// 		keyboard.d().onPressDo({mario.mover(mario.position().right(1))})

//     keyboard.w().onPressDo({mario.mover(mario.position().up(1))})
    
// 		keyboard.s().onPressDo({mario.mover(mario.position().down(1))})

//     keyboard.left().onPressDo({ mario.mover(mario.position().left(1)) })
    
// 		keyboard.right().onPressDo({mario.mover(mario.position().right(1))})

//     //keyboard.space().onPressDo({mario.saltar()})
//   }

//   method configurarColisiones() {  // con peach y fuegos, faltan plataformas y posicionar los personajes y algo para ganar score

//     game.onCollideDo(mario, {algo => algo.manosiadoPorMario()})
//   }
// }
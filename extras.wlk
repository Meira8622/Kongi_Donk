import wollok.game.*
import mario.*
import niveles.*
import enemigos.*

object generadorDeObjetos {
  method generarMoneda() {
    const nuevaMoneda = new Moneda(position = game.at(1.randomUpTo(14), 1.randomUpTo(14)))
    game.addVisual(nuevaMoneda)
  }

}
class Moneda {
  var property position
  var property recogida = false
  var property sufijo = 1

  //quiza se puede hacer que la moneda gire? re extra pero quedaria re bien
  method image() = "money"+ sufijo + ".png"

  method recoger() {
    recogida = true
    game.removeVisual(self)
    mario.ganarMoneda()
  }

  method manosiadoPorMario() {
    if (!recogida) {
      self.recoger()
    }
  }
}



object menu {
    method image() = "kongstill0.png"

    method position() = game.center()

    method text() = "

    KONGI DONK






    Pulsa Espacio para iniciar!"
  
    method textColor() = "c31212cc"

    method iniciarMenu(){
    game.stop()
    game.addVisual(self)
    self.iniciarJuego()
    
  }


    method iniciarJuego(){
        keyboard.space().onPressDo({juego.iniciar()})
        keyboard.space().onPressDo({game.removeVisual(self)})
    }

}

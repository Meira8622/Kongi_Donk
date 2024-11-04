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


object moneda_inherte{
  method image() = "money1.png"
  method position() = game.at(game.width() - 2,0)
}

object contador_moneda{

  method text() = mario.monedas().toString()
  method textColor() = "FFFFFF"
  method position() = game.at(game.width() - 1,0)

}



import wollok.game.*
import mario.*
import niveles.*
import enemigos.*

object generadorDeObjetos {
  method generarMoneda() {
    const nuevaMoneda = new Moneda(position = game.at(1.randomUpTo(15), 1.randomUpTo(15)))
    game.addVisual(nuevaMoneda) // Inicia la moneda
  }

}
class Moneda {
  var property position
  var property recogida = false

  //quiza se puede hacer que la moneda gire? re extra pero quedaria re bien
  method image() = "coin4.png"

  method recoger() {
    recogida = true
    game.removeVisual(self)
    mario.ganarMoneda()
  }

  // Método para verificar si Mario ha recogido la moneda
  method manosiadoPorMario() {
    if (!recogida) {
      self.recoger() // Si hay colisión, recoge la moneda
    }
  }
}

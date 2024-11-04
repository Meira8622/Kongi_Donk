import wollok.game.*
import mario.*
import niveles.*
import enemigos.*

object generadorDeObjetos {
  method generarMoneda() {
    const nuevaMoneda = new Moneda(position = game.at(1.randomUpTo(14), 1.randomUpTo(14)))
    game.addVisual(nuevaMoneda)
    nuevaMoneda.iniciarAnimacion()
  }

}
class Moneda {
  var property position
  var property recogida = false
  var property sufijo = 1

  //quiza se puede hacer que la moneda gire? re extra pero quedaria re bien
  method image() = "coin"+ sufijo + ".png"

  method iniciarAnimacion() {
    self.animarMoneda() // Llama al metodo de animación al inicio
  }

  method animarMoneda() {
    game.schedule(100, {
      if (sufijo < 5) {
        sufijo += 1
      } else {
        sufijo = 1
      }
      game.removeVisual(self) // Remueve la moneda para actualizar la imagen
      game.addVisual(self) // Vuelve a agregarla con la nueva imagen
      self.animarMoneda() // Continua el ciclo de animación
    })
  }

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

import wollok.game.*
import mario.*
import niveles.*
import enemigos.*

class Moneda {
  var property position // Posición de la moneda
  var property recogida = false // Estado de la moneda, si ha sido recogida o no

  method image() = "coin4.png" // Imagen de la moneda

  method recoger() {
    recogida = true // Cambia el estado a recogida
    game.removeVisual(self) // Elimina la moneda del juego
    mario.ganarMoneda() // Llama al método para que Mario gane una moneda
  }

  // Método para verificar si Mario ha recogido la moneda
  method manosiadoPorMario() {
    if (!recogida && game.onSameCell(mario, self)) {
      self.recoger() // Si hay colisión, recoge la moneda
    }
  }

  // Método para generar una moneda en una posición aleatoria
  method generarMoneda() {
    const nuevaMoneda = new Moneda(position = game.at(1.randomUpTo(15), 1.randomUpTo(15)))

    game.addVisual(self) // Inicia la moneda
  }
}

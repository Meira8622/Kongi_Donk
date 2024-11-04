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
    if (not recogida) {
      self.animarMoneda() 
      self.manosiadoPorMario() 
    }
  }

  method animarMoneda() {
    if (not recogida) { 
      game.schedule(100, {
        if (sufijo < 5) {
          sufijo += 1
        } else {
          sufijo = 1
        }
        self.animarMoneda() 
      })
    }
  }

  method recoger() {
    recogida = true
    game.removeVisual(self)
    mario.ganarMoneda()
    recogida = false
  }

  method manosiadoPorMario() {
    game.schedule(50, {
      if (!recogida && self.estaCercaDe(mario)) {  
        self.recoger()
      } else if (!recogida) {
        self.manosiadoPorMario() 
      }
    })
  }

  method estaCercaDe(objeto) {
    var distanciaX = (self.position().x() - objeto.position().x()).abs()
    var distanciaY = (self.position().y() - objeto.position().y()).abs()
    return distanciaX <= 1 && distanciaY <= 1 
  }
}

import wollok.game.*
import niveles.*
import extras.* 
import enemigos.*


object mario {

  var property vidas = 3
  var property position = game.center()

  var property xDesde = 0
  var property yDesde = 0
  var property xHasta = 14
  var property yHasta = 19


  var sufijo = "right"

    method image() = "mario-"+ sufijo +".png"
    
    method mover(nuevaPosicion) {
      
      if (nuevaPosicion.x() >= xDesde && nuevaPosicion.x() <= xHasta && 
        nuevaPosicion.y() >= yDesde && nuevaPosicion.y() <= yHasta &&
        vidas != 0) {
          if (nuevaPosicion.x() > position.x()) {
            sufijo = "right"
        } else if (nuevaPosicion.x() < position.x()) {
            sufijo = "left"
        }
        position = nuevaPosicion
      }
      
    }

  method saltar() {
    var backupSufijo = sufijo

    if(position.y()<=2 && vidas != 0){
      sufijo = sufijo +"-saltito"
        self.play()   
        position = position.up(3)
        game.schedule(300, { position = position.down(3) 
        sufijo = backupSufijo})
    }
	}

  method play() = game.sound("jump.wav").play()
  method playMuerte() = game.sound("mario-game-over.mp3").play()
  method playDanio() = game.sound("mario-danio.mp3").play()

  method perderVidas() {
    vidas -= 1
    if(vidas != 0){
      game.say(self, "me quedan " + self.vidas() + " vida/s")
      self.playDanio()
      marioVidas.perderCorazon()

    }else{
      sufijo = "muerte"
      position = position.up(1)
      game.say(self, "llamen a dios")
      self.playMuerte()
      marioVidas.perderCorazon()

      game.schedule(200, { position = position.down(1)})
      juego.terminar()
    }
  }
  method verificarPosicion(nuevaPosi) {
    return nuevaPosi.between(xDesde, xHasta) || nuevaPosi.between(yDesde, yHasta)
  }


}
//object vida1 inherits Vida{}

object marioVidas {
  
  var property vida1 =  new Vida(position = game.at(0,9))
  var property vida2 =  new Vida(position = game.at(1,9))
  var property vida3 =  new Vida(position = game.at(2,9))

  var property vidas = [vida1, vida2, vida3]
  
  method perderCorazon() = vidas.remove(vidas.last())

}

class Vida{

  var property position

  method image() = "heart.png"

}
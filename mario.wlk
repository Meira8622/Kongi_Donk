import wollok.game.*
import niveles.*
import extras.* 
import enemigos.*


object mario {

  var property vidas = 3
  var property monedas = 0 
  var property position = game.center()
  var property invulnerabilidad = false

  var sufijo = "right"

  method image() = "mario1-"+ sufijo +".png"
  
  method mover(nuevaPosicion) {
    if (self.inBoundsCheck(nuevaPosicion) && vidas != 0) {
        if (nuevaPosicion.x() > position.x()) {
          sufijo = "right"
      } else if (nuevaPosicion.x() < position.x()) {
          sufijo = "left"
      }
      position = nuevaPosicion
    }
  }

  method play() = game.sound("jump.wav").play()
  method playMuerte() = game.sound("mario-game-over.mp3").play()
  method playDanio() = game.sound("mario-danio.mp3").play()
  method playMoneda() = game.sound("coin.wav").play()

  method perderVidas() {
    if(!invulnerabilidad){
      vidas -= 1
      if(vidas != 0){
        game.say(self, "me quedan " + self.vidas() + " vida/s")
        self.playDanio()
        marioVidas.perderCorazon()
        self.invulnerable()

      }else{
        sufijo = "muerte"
        position = position.up(1)
        game.say(self, "llamen a dios")
        self.playMuerte()
        marioVidas.perderCorazon()
        self.invulnerable()


        game.schedule(200, { position = position.down(1)})
        juego.terminar()
      }}
  }
  method inBoundsCheck(newPos) = newPos.y() <=game.height()-1 && newPos.y() >= 0 && newPos.x() >=0 && newPos.x() <= game.width()-1
  method invulnerable(){
    invulnerabilidad = true
    game.schedule(1000, { invulnerabilidad = false })
  }

  method ganarMoneda() {
    monedas = monedas + 1
    self.playMoneda()
    //Agregar contador de monedas
  }
}

object marioVidas {
  const vidas = [vidaInicial]

  var property vidaInicial = new Vida(position = game.at(0, 0))
  method ganarCorazon() {
    var vidaExtra
    vidaExtra = new Vida(position = game.at(vidas.last().position().x()+1, 0))
    vidas.add(vidaExtra)
  }
  method perderCorazon(){
    game.removeVisual(vidas.last())
    vidas.remove(vidas.last())
  }
  method inicializarVidas(){
    self.ganarCorazon()
    self.ganarCorazon()
    vidas.forEach{vida => game.addVisual(vida)}
  }
}

class Vida{

  var property position

  method image() = "corazon1.png"

}
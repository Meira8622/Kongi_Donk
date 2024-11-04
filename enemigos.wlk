import wollok.game.*
import mario.*
import niveles.*
import extras.*

object donkeyKong {
    var property position = game.at(0,0)
    const proyectilesActivos=[]
    var donkeyVertical= true
    method aparecerAleatorio() {
        if(donkeyVertical){ //donkey en x=0
            position = game.at(0, 0.randomUpTo(game.height()-1))
            donkeyVertical = false
        }else{ //donkey en y=game.height()-1
            position = game.at(0.randomUpTo(game.width()-1) , game.height()-1)
            donkeyVertical = true
        }
    }

    method image() = "kong0.png"
    method playGolpe() = game.sound("kong-golpe.mp3").play()
    method lanzarProyectil() {
        var proyectil
        if(!donkeyVertical){
            proyectil = new Fuegos(position = self.position().right(1))
            game.addVisual(proyectil)
            proyectilesActivos.add(proyectil)
        } else {
            proyectil = new FuegosVerticales(position = self.position().down(1))
            game.addVisual(proyectil)
            proyectilesActivos.add(proyectil)
        }
    }
    method moverProyectiles(){
        proyectilesActivos.forEach({proyectil => if(!proyectil.estaDetenido()){proyectil.desplazarse()} else proyectilesActivos.remove(proyectil)})
    }

    method manosiadoPorMario(){
        if(donkeyKong.position().x() == 0){
            mario.mover(mario.position().right(1))
            mario.perderVidas()
            game.say(self, "Salí Mario")
            self.playGolpe()
        } else {
            mario.mover(mario.position().down(1))
            mario.perderVidas()
            game.say(self, "Salí Mario")
            self.playGolpe()
        }
    }

}


class Proyectiles { //se podrian agregar mas
    var property position 
    var property detenido = false
   
    method inBounds() = position.y() <=game.height() && position.y() >= 0 && position.x() >=0 && position.x() <= game.width()
    method desplazarse()
    method estaDetenido() = detenido
    method detenerse() {
        game.removeVisual(self)
        detenido = true
    }
}


class Fuegos inherits Proyectiles {
    method image() = "fireballright.png"
    override method desplazarse() { 
        if(self.inBounds()){
            position = position.right(1)
        } else {
            self.detenerse()
        }
    } 
    method manosiadoPorMario(){
        mario.perderVidas()
        self.detenerse()
    }
}
class FuegosVerticales inherits Fuegos{
    override method image() = "fireballdown.png"
    override method desplazarse() { 
        if(self.inBounds()){
            position = position.down(1)
        } else {
            self.detenerse()
        }
    } 
}

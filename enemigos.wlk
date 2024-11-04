import wollok.game.*
import mario.*
import niveles.*
import extras.*

object donkeyKong {
    var property position = game.at(0,0)
    const proyectilesActivos=[]
    method aparecerAleatorio() {  
     position = game.at(0, 0.randomUpTo(game.height()-1))
    }

    method image() = "kong0.png"

    method lanzarProyectil() {
        var proyectil
        proyectil = new Fuegos(position = self.position().right(1))
        game.addVisual(proyectil)
        proyectilesActivos.add(proyectil)
    }
    method moverProyectiles(){
        proyectilesActivos.forEach({proyectil => if(!proyectil.estaDetenido()){proyectil.desplazarse()} else proyectilesActivos.remove(proyectil)})
    }

    method manosiadoPorMario(){
        mario.mover(mario.position().right(1))
        mario.perderVidas()
        game.say(self, "Salí Mario")
        //Poner ruido de sopapo
        return true
    }

}


class Proyectiles { //se podrian agregar mas
    method inBounds() = position.y() <=game.height() && position.y() >= 0 && position.x() >=0 && position.x() <= game.width()
    var property position 
    var property detenido = false
    method inicializarProyectiles() {
    }
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

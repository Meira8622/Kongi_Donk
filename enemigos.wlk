import wollok.game.*
import mario.*
import niveles.*
import extras.*

object donkeyKong {
    var property position = game.at(0,0)

    method aparecerAleatorio() {  
     position = game.at(0, 0.randomUpTo(game.height()))
    }


    method image() = "kong0.png"

    method lanzarProyectil() {
        var proyectil

        proyectil = new Fuegos(position = self.position())
        game.addVisual(proyectil)
        game.onTick(1000, "lanzar", { proyectil.recorrido() })

    }

    method manosiadoPorMario(){

        return true
        game.say(self, "Salí Mario")

    }

}


class Proyectiles { //se podrian agregar mas

    var property position 
    
    //method quema() = true
    method recorrido() {
        game.onTick(500, self.tick(), { self.desplazarse() })
    }

    method desplazarse()

    method tick()

    method detenerse() {
        game.removeTickEvent(self.tick())
        game.removeVisual(self)
    }
}


class Fuegos inherits Proyectiles {

    method image() = "fireballright.png"
    override method desplazarse() { 
        position = position.right(1)
    }
    override method tick() = "fuegos"

    method manosiadoPorMario(){
        mario.perderVidas()
        self.detenerse()
    }


}

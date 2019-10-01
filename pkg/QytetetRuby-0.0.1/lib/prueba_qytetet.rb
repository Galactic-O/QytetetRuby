# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding :utf­8

require_relative "tipo_sorpresa"
require_relative "sorpresa"
require_relative "tablero"
require_relative "tipo_casilla"
require_relative "casilla"
require_relative "titulo_propiedad"
require_relative "qytetet"

module ModeloQytetet
  class PruebaQytetet
    
    @@juego = Qytetet.instance
    
    def PruebaQytetet.getMasQueCero()
      mazotemporal = Array.new
      @@juego.mazo.each do |carta|
        if carta.valor > 0
          mazotemporal << carta
        end
      end
      return mazotemporal
    end
    
    def PruebaQytetet.getIrACasilla()
      mazotemporal = Array.new
      @@juego.mazo.each do |carta|
        if carta.tipo == TipoSorpresa::IRACASILLA 
          mazotemporal << carta
        end
      end
      return mazotemporal
    end
    
    def PruebaQytetet.getSorpresa(tipo)
      mazotemporal = Array.new
      @@juego.mazo.each do |carta|
        if carta.tipo == tipo 
          mazotemporal << carta
        end
      end
      return mazotemporal
    end
    
    def PruebaQytetet.get_nombre_jugadores
      puts "Inserta el numero de jugadores: "
      numero = gets.to_i
      
      nombres = Array.new
      for i in 1..numero do
        puts "Inserta tu nombre, Jugador " + i.to_s + " :"
        cadena = gets
        nombres << cadena
      end
      puts "\n"
      return nombres
    end
    
    def PruebaQytetet.main
      
      @@juego.inicializar_juego(get_nombre_jugadores)
      
      puts "Esto es una prueba. Los metodos aqui usados no formaran parte del codigo final." << "\n" << "\n"
      
      @@juego.salida_jugadores
      
      puts "\nAhora va a jugar: " << @@juego.jugador_actual.nombre
      @@juego.mover(1)
      
      @@juego.comprar_titulo_propiedad
      
      otro = @@juego.jugador_actual
      
      @@juego.siguiente_jugador
      
      puts "\nAhora va a jugar: " << @@juego.jugador_actual.nombre
      @@juego.mover(4)
      
      @@juego.comprar_titulo_propiedad
      
      puts "\n\n\n---- RESULTADOS FINALES DE LA PRUEBA ----\n"
      
      puts @@juego.jugador_actual.to_s
      puts otro.to_s
      
      #PRUEBAS DE LA SESION 1 PRACTICA 1
      #puts "Carta con un valor mayor que cero: "
      #puts getMasQueCero() << "\n"
      
      #puts "Carta del tipo Ir a Casilla: "
      #puts getIrACasilla() << "\n"
      
      #puts "Carta del tipo que tu quieras: "
      #puts getSorpresa(TipoSorpresa::PAGARCOBRAR) << "\n"
      
      #PRUEBAS DE LA PRACTICA 1 SESION 2
      #puts "Casillas del tablero: "
      #puts @@juego.tablero
    end
    
  end
  
  PruebaQytetet.main
  
end
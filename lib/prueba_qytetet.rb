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
    
    @@juego = Qytetet.new
    @tablero
    
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
    
    def PruebaQytetet.main
      @@juego.inicializarCartasSorpresa()
      @@juego.inicializarTablero()
      
      puts "Esto es una prueba." << "\n" << "\n"
      
      #PRUEBAS DE LA SESION 1 PRACTICA 1
      #puts "Carta con un valor mayor que cero: "
      #puts getMasQueCero() << "\n"
      
      #puts "Carta del tipo Ir a Casilla: "
      #puts getIrACasilla() << "\n"
      
      #puts "Carta del tipo que tu quieras: "
      #puts getSorpresa(TipoSorpresa::PAGARCOBRAR) << "\n"
      
      #PRUEBAS DE LA PRACTICA 1 SESION 2
      puts "Casillas del tablero: "
      puts @@juego.tablero.to_s
    end
    
  end
  
  PruebaQytetet.main
  
end
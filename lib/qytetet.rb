# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding :utf­8
require "singleton"
require_relative 'sorpresa'
require_relative 'tipo_sorpresa'
require_relative 'tablero'
require_relative 'dado'
require_relative 'jugador'
require_relative 'metodo_salir_carcel'

module ModeloQytetet
  class Qytetet
    attr_reader :mazo, :tablero, :carta_actual, :dado, :jugador_actual, :jugadores
    attr_writer :carta_actual
    
    include Singleton
    
    MAX_JUGADORES = 4
    NUM_SORPRESAS = 10
    NUM_CASILLAS = 20
    PRECIO_LIBERTAD = 2000
    SALDO_SALIDA = 1000
    
    def initialize
      @mazo = []
      @carta_actual
      @tablero
      @dado
      @jugadores = []
      @jugador_actual
    end
    
    def actuar_si_en_casilla_edificable
      raise NotImplementedError
    end
    
    def actuar_si_en_casilla_no_edificable
      raise NotImplementedError
    end
    
    def aplicar_sorpresa
      raise NotImplementedError
    end
    
    def cancelar_hipoteca(numeroCasilla)
      raise NotImplementedError
    end
    
    def comprar_titulo_propiedad
      raise NotImplementedError
    end
    
    def edificar_casa(numeroCasilla)
      raise NotImplementedError
    end
    
    def edificar_hotel(numeroCasilla)
      raise NotImplementedError
    end
    
    def encarcelar_jugador
      raise NotImplementedError
    end
    
    def valor_dado
      raise NotImplementedError
    end
    
    def hipotecar_propiedad
      raise NotImplementedError
    end
    
    def inicializar_cartas_sorpresa
      @mazo = Array.new
      @mazo<< Sorpresa.new("Sube el bitcoin. Ganas 100 euros.", 100, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("Tienes tanta hambre que te comes tu billete de 100 euros. Ups.", -100, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("Dia de la marmota. Vuelve a la salida.", 1, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Tienes que comprar tomates en el Mercadona. Ve al Parking.", 4, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Te han pillado haciendo el dab en publico, das 
                          tanto cringe que te meten en la carcel.", 6, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Tus casas estan infestadas de abejas. Pagas 50 euros por cada casa u hotel.", -50, TipoSorpresa::PORCASAHOTEL)
      @mazo<< Sorpresa.new("Explota la burbuja, inundando tus propiedades. Ahora son spas. Ganas 50 por cada casa u hotel.", 50, TipoSorpresa::PORCASAHOTEL)
      @mazo<< Sorpresa.new("Los otros jugadores te confunden con una maquina expendedora pr culpa de las drogas. 
                          Te roban 10 euros cada uno.", -10, TipoSorpresa::PORJUGADOR)
      @mazo<< Sorpresa.new("Compras un aspirador mu tocho. Robas 10 euros a cada jugador.", 10, TipoSorpresa::PORJUGADOR)
      @mazo<< Sorpresa.new("Practicas tus mortales hacia atras hasta que puedes saltar muros. Sales de la carcel.", 0, TipoSorpresa::SALIRCARCEL)
    end  
    
    def inicializar_tablero
      @tablero = Tablero.new
      @dado = Dado.instance
    end
    
    def inicializar_jugadores(nombres)
      nombres.each do |nom|
        jugadores << Jugador.new(nom)
      end
    end
    
    def inicializar_juego(nombres)
      inicializar_jugadores(nombres)
      inicializar_tablero
      inicializar_cartas_sorpresa
    end
    
    def intentar_salir_carcel(metodo)
      
    end
    
    def jugar
      raise NotImplementedError
    end
    
    def mover
      raise NotImplementedError
    end
    
    def obtener_casilla_jugador_actual
      raise NotImplementedError
    end
    
    def obtener_casillas_tablero
      raise NotImplementedError
    end
    
    def obtener_propiedades_jugador
      
    end
    
    def obtener_propiedades_jugador_segun_estado_hipoteca
      raise NotImplementedError
    end
    
    def obtener_ranking
      raise NotImplementedError
    end
    
    def obtener_saldo_jugador_actual
      raise NotImplementedError
    end
    
    def salida_jugadores
      raise NotImplementedError
    end
    
    def siguiente_jugador
      raise NotImplementedError
    end
    
    def tirar_dado
      raise NotImplementedError
    end
    
    def vender_propiedad(numero_casilla)
      raise NotImplementedError
    end
  end
end
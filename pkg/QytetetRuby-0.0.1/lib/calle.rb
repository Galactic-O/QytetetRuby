# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  
  class Calle < Casilla
    attr_reader :titulo
    attr_writer :titulo
    
    def initialize(numero_casilla, titulo)
      super(TipoCasilla::CALLE, numero_casilla, titulo.precio_compra)
      @titulo = titulo
    end
    
    def asignar_propietario(jugador)
      @titulo.propietario = jugador
      return @titulo
    end
    
    def tengo_propietario
      return @titulo.tengo_propietario
    end
    
    def propietario_encarcelado
      return @titulo.propietario_encarcelado
    end
    
    def soy_edificable
      return true
    end
    
    def pagar_alquiler
      coste_alquiler = @titulo.pagar_alquiler
      return coste_alquiler
    end
  end
end

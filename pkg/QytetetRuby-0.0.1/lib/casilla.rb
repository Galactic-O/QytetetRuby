# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla, :tipo, :coste
    
    def initialize(tipo_casilla, numero_casilla, coste)
      @tipo = tipo_casilla
      @numero_casilla = numero_casilla
      @coste = coste
    end
    
    def pagar_alquiler
      return @titulo.pagar_alquiler()
    end
    
    def tengo_propietario
      return false
    end
    
    def soy_edificable
      return false
    end
    
    def to_s
      t = "Casilla: #{@numero_casilla}\nCoste de la casilla: #{@coste}\nTipo de casilla: #{@tipo}\nTitulo: "
      unless @titulo == nil
        t+= "#{@titulo.nombre}\n\n"
      else
        t+="No tiene\n\n"
      end
      return t
    end
  end
end

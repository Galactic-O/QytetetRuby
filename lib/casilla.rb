# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModuloQytetet
  class Casilla
    attr_reader :numero_casilla, :coste, :tipo, :titulo
    attr_writer :titulo
    
    def initialize(tipoCasilla, coste, numeroCasilla, tituloPropiedad)
      @TipoCasilla = tipoCasilla
      @coste = coste
      @numeroCasilla = numeroCasilla
      @TituloPropiedad = tituloPropiedad
    end
    
    def self.newCalle(numeroCasilla, titulo)
      self.new(TipoCasilla::CALLE, titulo.precioCompra, numeroCasilla, titulo)
    end
    
    def self.newImpuesto(numeroCasilla, coste)
      self.new(TipoCasilla::IMPUESTO, coste, numeroCasilla, nil)
    end
    
    def self.newSorpresa(numeroCasilla)
      self.new(TipoCasilla::SORPRESA, 0, numeroCasilla, nil)
    end
    
    def self.newSalida(numeroCasilla)
      self.new(TipoCasilla::SALIDA, 1000, numeroCasilla, nil)
    end
    
     def self.newJuez(numeroCasilla)
      self.new(TipoCasilla::JUEZ, 0, numeroCasilla, nil)
    end
    
    def self.newParking(numeroCasilla)
      self.new(TipoCasilla::PARKING, 0, numeroCasilla, nil)
    end
    
    def self.newCarcel(numeroCasilla)
      self.new(TipoCasilla::CARCEL, 0, numeroCasilla, nil)
    end
    
    def to_s
      texto = "Estas en la casilla: #{@numeroCasilla}\nCoste de la casilla: #{@coste}\nTipo de casilla: #{@tipo}\nTutlo: "
      unless @titulo == 0
        texto << "\n#{@titulo}"
      else
        texto << "No tiene"
        
      texto
      end
    end
  end
end

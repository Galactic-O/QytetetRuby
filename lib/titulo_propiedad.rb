# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

module ModeloQytetet
  class TituloPropiedad
    
    attr_reader :nombre, :hipotecada, :precioCompra, :alquilerBase, :factorRevalorizacion, :hipotecaBase, :precioEdificar, :numEdificios, :numCasas
    attr_accessor :hipotecada
    
    def initialize(nombre, precioCompra, alquilerBase, factorRevalorizacion, hipotecaBase, precioEdificar)
      @nombre = nombre
      
      @precioCompra = precioCompra
      @alquilerBase = alquilerBase
      @factorRevalorizacion = factorRevalorizacion
      @hipotecaBase = hipotecaBase
      
      @precioEdificar = precioEdificar
      
      @hipotecada = false
      @numHoteles = 0
      @numCasas = 0
    end
    
    public
    def to_s
      "Nombre: #{@nombre}. \n Hipotecada: #{@hipotecada}. \n Alquiler base: #{@alquiler_base}. \n" + 
      "Factor de revalorizacion: #{@factor_revalorizacion}. \n Hipoteca base: #{@hipoteca_base}. \n" + 
      "Precio de edificacion: #{@precio_edificar}."
    end
  end
end

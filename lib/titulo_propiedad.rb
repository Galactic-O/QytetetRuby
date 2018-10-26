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
      @alquiler_base = alquilerBase
      @factor_revalorizacion = factorRevalorizacion
      @hipoteca_base = hipotecaBase
      
      @precio_edificar = precioEdificar
      
      @hipotecada = false
      @numHoteles = 0
      @numCasas = 0
      
      @propietario = nil
    end
    
    def calcular_coste_cancelar
      raise NotImplementedError
    end
    
    def calcular_coste_hipotecar
      raise NotImplementedError
    end
    
    def calcular_importe_alquiler
      raise NotImplementedError
    end
    
    def calcular_precio_venta
      raise NotImplementedError
    end
    
    def cancelar_hipoteca
      raise NotImplementedError
    end
    
    def cobrar_alquiler(coste)
      raise NotImplementedError
    end
    
    def edificar_casa
      raise NotImplementedError
    end
    
    def edificar_hotel
      raise NotImplementedError
    end
    
    def hipotecar
      raise NotImplementedError
    end
    
    def pagar_alquiler
      raise NotImplementedError
    end
    
    def propietario_encarcelado
      raise NotImplementedError
    end
    
    def tengo_propietario
      raise NotImplementedError
    end
    
    public
    def to_s
      " Nombre: #{@nombre}. \n Hipotecada: #{@hipotecada}. \n Alquiler base: #{@alquiler_base}. \n" + 
      " Factor de revalorizacion: #{@factor_revalorizacion}. \n Hipoteca base: #{@hipoteca_base}. \n" + 
      " Precio de edificacion: #{@precio_edificar}. \n Propietario:#{@propietario}"
    end
  end
end

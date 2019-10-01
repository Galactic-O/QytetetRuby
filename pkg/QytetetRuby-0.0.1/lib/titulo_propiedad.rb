# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

module ModeloQytetet
  class TituloPropiedad
    
    attr_reader :nombre, :hipotecada, :precio_compra, :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edificar, :num_hoteles, :num_casas
    attr_accessor :hipotecada, :propietario
    
    def initialize(nombre, precio_compra, alquiler_base, factor_revalorizacion, hipoteca_base, precio_edificar)
      @nombre = nombre
      
      @precio_compra = precio_compra
      @alquiler_base = alquiler_base
      @factor_revalorizacion = factor_revalorizacion
      @hipoteca_base = hipoteca_base
      
      @precio_edificar = precio_edificar
      
      @hipotecada = false
      @num_hoteles = 0
      @num_casas = 0
      
      @propietario = nil
    end
    
    def calcular_coste_cancelar
      raise NotImplementedError
    end
    
    def calcular_coste_hipotecar
      coste_hipoteca = (@hipoteca_base + (@num_casas * 0.5 * @hipoteca_base) + (@num_hoteles * @hipoteca_base))
      return coste_hipoteca
    end
    
    def calcular_importe_alquiler
      coste_alquiler = @alquiler_base + (@num_casas * 0.5 + @num_hoteles * 2)
      return coste_alquiler
    end
    
    def calcular_precio_venta
      precio_venta = (@precio_compra + (@num_casas + @num_hoteles) * @precio_edificar * @factor_revalorizacion)
      return precio_venta
    end
    
    def cancelar_hipoteca
      raise NotImplementedError
    end
    
    def cobrar_alquiler(coste)
      raise NotImplementedError
    end
    
    def edificar_casa
      @num_casas = @num_casas + 1
    end
    
    def edificar_hotel
      @num_hoteles = @num_hoteles + 1
      @num_casas = @num_casas - 4
    end
    
    def hipotecar
      @hipotecada = true
      coste_hipoteca = calcular_coste_hipotecar
      return coste_hipoteca
    end
    
    def is_hipotecada
      return @hipotecada
    end
    
    def pagar_alquiler
      coste_alquiler = calcular_importe_alquiler
      @propietario.modificar_saldo(coste_alquiler)
      return coste_alquiler
    end
    
    def propietario_encarcelado
      if tengo_propietario
        if @propietario.encarcelado == true
          return true
        end
      end
      return false
    end
    
    def tengo_propietario
      return (@propietario != nil)
    end
    
    public
    def to_s
      " Nombre: #{@nombre}. \n Hipotecada: #{@hipotecada}. \n Alquiler base: #{@alquiler_base}. \n" + 
      " Factor de revalorizacion: #{@factor_revalorizacion}. \n Hipoteca base: #{@hipoteca_base}. \n" + 
      " Precio de edificacion: #{@precio_edificar}. \n Propietario:#{@propietario}"
    end
  end
end

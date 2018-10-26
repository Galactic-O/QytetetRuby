# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Jugador
    attr_reader :casilla_actual, :carta_libertad, :encarcelado, :nombre, :propiedades, :saldo
    attr_writer :casilla_actual, :carta_libertad, :encarcelado
    
    def initialize(nombre)
      @nombre = nombre
      @saldo = 7500
      @encarcelado = false
      
      @casilla_actual = nil
      @carta_libertad = nil
      @propiedades = []
    end
    
    def cancelar_hipoteca(titulo)
        
    end
    
    def comprar_titulo_propiedad
      raise NotImplementedError 
    end
    
    def cuantas_casas_hoteles_tengo
      raise NotImplementedError 
    end
    
    def debo_pagar_alquiler
      raise NotImplementedError 
    end
    
    def devolver_carta_libertad
      raise NotImplementedError 
    end
    
    def edificar_casa(titulo)
      raise NotImplementedError 
    end
    
    def edificar_hotel(titulo)
      raise NotImplementedError 
    end
    
    def eliminar_de_mis_propiedades(titulo)
      raise NotImplementedError 
    end
    
    def es_de_mi_propiedad(titulo)
      raise NotImplementedError     
    end
    
    def estoy_en_calle_libre
      raise NotImplementedError 
    end
    
    def hipotecar_propiedad(titulo)
      raise NotImplementedError 
    end
    
    def ir_a_carcel(carcel)
      raise NotImplementedError 
    end
    
    def modificar_saldo(cantidad)
      raise NotImplementedError 
    end
    
    def obtener_capital
      raise NotImplementedError 
    end
    
    def obtener_propiedades(hipotecada)
      raise NotImplementedError 
    end
    
    def pagar_alquiler
      raise NotImplementedError 
    end
    
    def pagar_impuesto
      raise NotImplementedError 
    end
    
    def pagar_libertad(cantidad)
      raise NotImplementedError 
    end
    
    
    def tengo_carta_libertad
      raise NotImplementedError 
    end
    
    def tengo_saldo(cantidad)
      raise NotImplementedError 
    end
    
    def vender_propiedad(casilla)
      raise NotImplementedError 
    end
    
    def to_s
      
      cadena = "Jugador: #{@nombre}"
      
      if(@encarcelado)
        cadena = cadena + "Encarcelado: si. \n"
      else 
        cadena = cadena + "Encarcelado: no. \n"
      end
      
      cadena = cadena + "Saldo: #{@saldo}. \n"
      cadena = cadena + "Carta libertad: " + @carta_libertad.to_s + "\n"
      cadena = cadena + "Casilla actual: " + @casilla_actual.to_s + "\n"
      cadena = cadena + "Propiedades: \n"
      for s in @propiedades
        cadena = cadena + "#{s}. \n"
      end
      cadena = cadena + "\n"
      cadena
    end
    
  end
end

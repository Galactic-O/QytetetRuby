# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative "especulador"
require_relative "casilla"

module ModeloQytetet
  class Jugador
    attr_reader :nombre, :propiedades, :saldo
    attr_accessor :casilla_actual, :carta_libertad, :encarcelado
    
    def initialize(nombre)
      @nombre = nombre
      @saldo = 7500
      @encarcelado = false
      
      @casilla_actual = nil
      @carta_libertad = nil
      @propiedades = Array.new
    end
    
    def self.nuevo(nombre)
      new(nombre)
    end
    
    def self.copia(otroJugador)
      new(otroJugador.nombre, otroJugador.encarcelado, otroJugador.saldo, otroJugador.cartaLibertad, otroJugador.casillaActual, otroJugador.propiedades)
    end
    
    def cancelar_hipoteca(titulo)
      cancelar = false
      coste_cancelar = titulo.calcular_coste_cancelar
      tengo_saldo = tengo_saldo(coste_cancelar)
      
      if tengo_saldo
        modificar_saldo(-coste_cancelar)
        cancelar = titulo.cancelar_hipoteca
      end
      
      cancelar
    end
    
    def comprar_titulo_propiedad
      comprado = false
      coste_compra = @casilla_actual.coste
      if coste_compra < @saldo
        titulo = @casilla_actual.asignar_propietario(self)
        comprado = true
        propiedades<< titulo
        modificar_saldo(-coste_compra)
        puts "\nEl jugador " << @nombre << "ha comprado el titulo " << titulo.nombre
      end
      return comprado
    end
    
    def convertirme(fianza)
      espec = Especulador.copia(self, fianza);
      return espec;
    end
    
    def cuantas_casas_hoteles_tengo
      c = 0
      h = 0
      @propiedades.each do |prop|
        c = c+prop.num_casas
        h = h+prop.num_hoteles
      end
      return c+h
    end
    
    def debo_ir_a_carcel
      return !tengo_carta_libertad
    end
    
    def debo_pagar_alquiler
      titulo = @casilla_actual.titulo
      es_de_mi_propiedad = es_de_mi_propiedad(titulo)
      tiene_propietario = titulo.tengo_propietario
      encarcelado = titulo.propietario_encarcelado
      esta_hipotecada = titulo.is_hipotecada
      
      return (!es_de_mi_propiedad && tiene_propietario && !encarcelado && !esta_hipotecada)
    end 
    
    def devolver_carta_libertad
      carta = @carta_libertad
      @carta_libertad = nil
      return carta
    end
    
    def edificar_casa(titulo)
      edificada = puedo_edificar_casa(titulo)
      if edificada
        coste_edificar_casa = titulo.precio_edificar
        tengo_saldo = tengo_saldo(coste_edificar_casa)
        if tengo_saldo
          titulo.edificar_casa
          modificar_saldo(-coste_edificar_casa)
        end
      end
      return edificada
    end
    
    def edificar_hotel(titulo)
      edificada = puedo_edificar_hoteles(titulo)
      if edificada
        coste_edificar_hotel = titulo.precio_edificar
        tengo_saldo = tengo_saldo(coste_edificar_hotel)
        if tengo_saldo
          titulo.edificar_hotel
          modificar_saldo(-coste_edificar_hotel)
        end
      end
      return edificada
    end
    
    def eliminar_de_mis_propiedades(titulo)
      raise NotImplementedError 
    end
    
    def es_de_mi_propiedad(titulo)
      encontrado = false
      propiedades.each do |prop|
        if titulo == prop
          encontrado = true
        end
      end
      return encontrado
    end
    
    def estoy_en_calle_libre
      raise NotImplementedError 
    end
    
    def hipotecar_propiedad(titulo)
      coste_hipoteca = titulo.hipotecar
      modificar_saldo(coste_hipoteca)
    end
    
    def ir_a_carcel(carcel)
      @casilla_actual = carcel
      @encarcelado = true
    end
    
    def modificar_saldo(cantidad)
      @saldo = @saldo + cantidad
      return @saldo
    end
    
    def obtener_capital
      capital = saldo
      @propiedades.each do |prop|
        capital = capital + prop.precio_compra + ( prop.precio_edificar * (prop.num_casas + prop.num_hoteles) )
        if prop.is_hipotecada
          capital = capital - prop.get_hipoteca_base
        end
      end
      return capital
    end
    
    def obtener_propiedades(hipotecada)
      titulos = Array.new
      
      if(hipotecada == true)
        @propiedades.each do |prop|
          if(prop.hipotecada == true)
            titulos << prop
          end
        end
      end
      
      if(hipotecada == false)
        @propiedades.each do |prop|
          if(prop.hipotecada == false)
            titulos << prop
          end
        end
      end
      return titulos
    end
    
    def pagar_alquiler
      coste_alquiler = @casilla_actual.pagar_alquiler
      modificar_saldo(-coste_alquiler)
    end
    
    def pagar_impuesto
      @saldo = @saldo - @casilla_actual.coste
    end
    
    def pagar_libertad(cantidad)
      tengo_saldo = tengo_saldo(cantidad)
      if tengo_saldo
        @encarcelado = false
        modificar_saldo(-cantidad)
      end
    end
    
    def puedo_edificar_casa(titulo)
      edificable = false
      num_casas = @titulo.get_num_casas
      if (num_casas < 4)
        edificable = true;
      end
      return edificable
    end
    
    def puedo_edificar_hotel(titulo)
      edificable = false
      num_casas = titulo.get_num_casas
      num_hoteles = titulo.get_num_hoteles
      if (num_casas >= 4 && num_hoteles < 4)
        edificable = true;
      end
      return edificable
    end
    
    def tengo_carta_libertad
      return (@carta_libertad != nil) 
    end
    
    def tengo_saldo(cantidad)
      return (@saldo > cantidad)
    end
    
    def vender_propiedad(casilla)
      titulo = casilla.titulo
      propiedades.delete(titulo)
      titulo.propietario = nil
    end
    
    def to_s
      
      cadena = "\nJugador: #{@nombre}"
      
      if(@encarcelado)
        cadena = cadena + "Encarcelado: si. \n"
      else 
        cadena = cadena + "Encarcelado: no. \n"
      end
     
      cadena = cadena + "Saldo: #{@saldo}. \n"
      cadena = cadena + "Carta libertad: " + @carta_libertad.to_s + "\n"
      cadena = cadena + "Casilla actual: \n" + @casilla_actual.to_s
      cadena = cadena + "Propiedades: \n"
      for s in @propiedades
        cadena = cadena + "-#{s.nombre}. \n"
      end
      cadena = cadena + "\n ---------- \n"
      cadena
    end
    
  end
end

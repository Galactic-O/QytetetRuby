# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "controlador_qytetet"


module VistaTextualQytetet
  class VistaTextualQytetet
    
    include ControladorQytetet
    
    attr_reader :controlador
    
    def initialize
      @controlador = ControladorQytetet.instance
    end
    
    def leer_valor_correcto(valores_correctos)
      valido = false
      begin 
        puts "\nIntroduce la orden: "
        lectura = gets.chomp
        
        for i in valores_correctos
          if lectura == i
            valido = true
          end
        end
        
        if !valido
          puts "Orden no valida."
        end
        
      end while(!valido)
      return lectura
    end
    
    def elegir_operacion
      lista =  @controlador.obtener_operaciones_juego_validas
      lista_a_string = Array.new
      puts "\nOrdenes disponibles: \n"
      
      for i in lista
        lista_a_string << i.to_s
        puts i.to_s + " " + OpcionMenu.at(i).to_s + "\n"
      end
      
      return Integer(leer_valor_correcto(lista_a_string))
    end
    
    def elegir_casilla(op_menu)
      lista = @controlador.obtener_casillas_validas(op_menu)
      
      if(!lista.empty?)
        puts lista.to_s 
        
        valido = false
        
        begin
          puts "\nElige una casilla: "
          lectura = gets.chomp.to_i
          
          for i in lista
            if lectura == i
              valido = true
            end
          end
          
          if(valido)
            return lectura
          end
        end while(!valido)
      else
        return -1
      end
    end
    
    def obtener_nombres_jugadores
      
      puts "Numero de jugadores: "
      numero = gets.to_i
      
      nombres = Array.new
      
      puts "Insertar nombres de los jugadores: "
      
      for i in 1..numero do
        puts "Nombre del jugador #{i} :" 
        cadena = gets
        nombres << cadena
      end
      
      return nombres
      
    end
    
    def self.main
      ui = VistaTextualQytetet.new
       ui.controlador.set_nombre_jugadores(ui.obtener_nombres_jugadores)
      
      operacion_elegida = 0
      casilla_elegida = 0
      begin
        operacion_elegida = ui.elegir_operacion
        necesita_elegir_casilla =  ui.controlador.necesita_elegir_casilla(operacion_elegida)
        
        if necesita_elegir_casilla
          casilla_elegida = ui.elegir_casilla(operacion_elegida)
        end
        
        if (!necesita_elegir_casilla || casilla_elegida >= 0)
          puts  ui.controlador.realizar_operacion(operacion_elegida, casilla_elegida)
        end
      end while(1==1)
    end
    
  end
  VistaTextualQytetet.main
end
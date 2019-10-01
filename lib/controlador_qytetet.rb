# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require "singleton"
require_relative 'estado_juego'
require_relative 'metodo_salir_carcel'
require_relative 'qytetet'
require_relative 'opcion_menu'


module ControladorQytetet
  class ControladorQytetet
    include Singleton
    include ModeloQytetet
    
    def initialize
      @modelo = Qytetet.instance
      @nombre_jugadores = Array.new
    end
    
    def set_nombre_jugadores(nombres)
      @nombre_jugadores = nombres
    end
    
    def obtener_operaciones_juego_validas
      validas = Array.new

      if( @modelo.jugadores == nil or @modelo.jugadores.empty?)
        validas << OpcionMenu.index(:INICIARJUEGO)
      else
        
        if( @modelo.estado_juego == EstadoJuego::ALGUNJUGADORENBANCARROTA)
          validas << OpcionMenu.index(:OBTENERRANKING)
        elsif ( @modelo.estado_juego == EstadoJuego::JA_PREPARADO)
          validas << OpcionMenu.index(:JUGAR)
        elsif( @modelo.estado_juego == EstadoJuego::JA_PUEDEGESTIONAR)
          validas << OpcionMenu.index(:PASARTURNO)
          validas << OpcionMenu.index(:VENDERPROPIEDAD)
          validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
          validas << OpcionMenu.index(:CANCELARHIPOTECA)
          validas << OpcionMenu.index(:EDIFICARCASA)
          validas << OpcionMenu.index(:EDIFICARHOTEL)
          validas << OpcionMenu.index(:PASARTURNO)
        elsif( @modelo.estado_juego == EstadoJuego::JA_PUEDECOMPRAROGESTIONAR)
          validas << OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
          validas << OpcionMenu.index(:VENDERPROPIEDAD)
          validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
          validas << OpcionMenu.index(:CANCELARHIPOTECA)
          validas << OpcionMenu.index(:EDIFICARCASA)
          validas << OpcionMenu.index(:EDIFICARHOTEL)
          validas << OpcionMenu.index(:PASARTURNO)
        elsif( @modelo.estado_juego == EstadoJuego::JA_CONSORPRESA) 
          validas << OpcionMenu.index(:APLICARSORPRESA)
        elsif( @modelo.estado_juego == EstadoJuego::JA_ENCARCELADO)
          validas << OpcionMenu.index(:PASARTURNO)
        elsif( @modelo.estado_juego == EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD)
          validas << OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
          validas << OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)
        end
          validas << OpcionMenu.index(:MOSTRARJUGADORES)
          validas << OpcionMenu.index(:MOSTRARTABLERO)
          validas << OpcionMenu.index(:TERMINARJUEGO)
          validas << OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          
      end
      
      return validas
    end
    
    
    def necesita_elegir_casilla(opcion_menu)
      op = opcion_menu
      return op == OpcionMenu.index(:HIPOTECARPROPIEDAD) || op == OpcionMenu.index(:CANCELARHIPOTECA) ||
             op == OpcionMenu.index(:EDIFICARCASA) || op == OpcionMenu.index(:EDIFICARHOTEL) ||
             op == OpcionMenu.index(:VENDERPROPIEDAD)
    end
    
    
    
    def obtener_casillas_validas(opcion_menu)
      lista_casillas = Array.new
     
      if(opcion_menu == :EDIFICARCASA || opcion_menu == :EDIFICARHOTEL ||
         opcion_menu == :VENDERPROPIEDAD)
       lista_casillas =  @modelo.obtener_propiedades_jugador
      else
        case opcion_menu
        when :HIPOTECARPROPIEDAD
          lista_casillas =  @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
        when :CANCELARHIPOTECA
          lista_casillas =  @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)
        end
      end
      return lista_casillas
    end
    

  
  def realizar_operacion(opcion_elegida, casilla_elegida)
         op = opcion_elegida
         mensaje = ""
         if (op == OpcionMenu.index(:INICIARJUEGO))
            @modelo.inicializar_juego(@nombre_jugadores)
         elsif (op == OpcionMenu.index(:JUGAR))
            @modelo.jugar
            mensaje += "El dado ha sido tirado y ha salido un: " + @modelo.get_valor_dado.to_s
         elsif (op == OpcionMenu.index(:APLICARSORPRESA))
            mensaje += "Sorpresa aplicada: " + @modelo.carta_actual.to_s
            @modelo.aplicar_sorpresa
         elsif (op == OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD))
            sale = @modelo.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
            mensaje += "\nIntentas salir de la carcel pagando."
            if !sale
               mensaje += "\nNo has podido salir de la carcel."
            end
         elsif (op == OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO))
            sale = @modelo.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
            mensaje += "\nIntentas salir de la carcel con dado."
            if !(sale)
               mensaje += "\nNo has podido salir de la carcel."
            end
         elsif (op == OpcionMenu.index(:COMPRARTITULOPROPIEDAD))
            @modelo.comprar_titulo_propiedad
         elsif (op == OpcionMenu.index(:HIPOTECARPROPIEDAD))
            @modelo.hipotecar_propiedad(casilla_elegida)
         elsif (op == OpcionMenu.index(:CANCELARHIPOTECA))
            @modelo.hipotecar_propiedad(casilla_elegida)
         elsif (op == OpcionMenu.index(:EDIFICARCASA))
            edificada = @modelo.edificar_casa(casilla_elegida)
         elsif (op == OpcionMenu.index(:EDIFICARHOTEL))
            edificada = @modelo.edificar_hotel(casilla_elegida)
         elsif (op == OpcionMenu.index(:VENDERPROPIEDAD))
            @modelo.vender_propiedad(casilla_elegida)
         elsif (op == OpcionMenu.index(:PASARTURNO))
            @modelo.siguiente_jugador
            mensaje += "\nPasas tu turno"
            mensaje += "\nAhora es el turno del jugador: " + @modelo.jugador_actual.to_s
         elsif (op == OpcionMenu.index(:OBTENERRANKING))
            i = 1
            @modelo.obtener_ranking
         elsif (op == OpcionMenu.index(:TERMINARJUEGO))
            exit(true)
         elsif (op == OpcionMenu.index(:MOSTRARJUGADORACTUAL))
            mensaje += @modelo.jugador_actual.to_s
         elsif (op == OpcionMenu.index(:MOSTRARJUGADORES))
            mensaje += @modelo.jugadores.join
         elsif (op == OpcionMenu.index(:MOSTRARTABLERO))
            mensaje += @modelo.tablero.to_s
         end
         
         return mensaje
      end
    end
  end
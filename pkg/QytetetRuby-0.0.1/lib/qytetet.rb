# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding :utf­8
require "singleton"
require_relative 'sorpresa'
require_relative 'tipo_sorpresa'
require_relative 'tablero'
require_relative 'dado'
require_relative 'jugador'
require_relative 'metodo_salir_carcel'
require_relative "estado_juego"

module ModeloQytetet
  class Qytetet
    attr_reader :mazo, :tablero, :carta_actual, :dado, :jugador_actual, :jugadores
    attr_writer :carta_actual
    attr_accessor :estado_juego
    
    include Singleton
    
    @@MAX_JUGADORES = 4
    @@NUM_SORPRESAS = 10
    @@NUM_CASILLAS = 20
    @@PRECIO_LIBERTAD = 2000
    @@SALDO_SALIDA = 1000
    
    def initialize
      @mazo = []
      @carta_actual
      @tablero
      @dado
      @jugadores = []
      @jugador_actual
      @estado_juego
    end
    
    def actuar_si_en_casilla_edificable
      debo_pagar = @jugador_actual.debo_pagar_alquiler
      if debo_pagar
        @jugador_actual.pagar_alquiler
        if @jugador_actual.saldo<=0
          set_estado_juego(EstadoJuego::ALGUNJUGADORENBANCARROTA)
        end
      end
      
      casilla = obtener_casilla_jugador_actual
      tengo_propietario = casilla.tengo_propietario
      if @estado_juego!=EstadoJuego::ALGUNJUGADORENBANCARROTA
        if tengo_propietario
          set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
        else
          set_estado_juego(EstadoJuego::JA_PUEDECOMPRAROGESTIONAR)
        end
      end
    end
    
    def actuar_si_en_casilla_no_edificable
      set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      casilla_actual = @jugador_actual.casilla_actual
      if casilla_actual.tipo == TipoCasilla::IMPUESTO
        @jugador_actual.pagar_impuesto
        if @jugador_actual.saldo<=0
          set_estado_juego(EstadoJuego::ALGUNJUGADORENBANCARROTA)
        elsif casilla_actual.tipo == TipoCasilla::CARCEL
          encarcelar_jugador
        elsif casilla_actual.tipo == TipoCasilla::SORPRESA
          puts "Has cogido una sorpresa"
          @cartaActual = @mazo[0]
          @mazo.delete_at(0)
          @mazo << @cartaActual
          set_estado_juego(EstadoJuego::JA_CONSORPRESA)
        end
      end
    end
    
    def aplicar_sorpresa
      set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      if @carta_actual.tipo == TipoSorpresa::PAGARCOBRAR
        @jugador_actual.carta_libertad(@carta_actual)
      else
        @mazo<< @carta_actual
        if @carta_actual.tipo == TipoSorpresa::PAGARCOBRAR
          @jugador_actual.modificar_saldo(@carta_actual.valor)
          if @jugador_actual.saldo<=0
            set_estado_juego(EstadoJuego::ALGUNJUGADORENBANCARROTA)
          end
        elsif @carta_actual.tipo == TipoSorpresa::IRACASILLA
          valor = @carta_actual.valor
          casilla_carcel = @tablero.es_casilla_carcel(valor)
          if casilla_carcel
            encarcelar_jugador
          else
            mover(valor)
          end
        elsif @carta_actual.tipo == TipoSorpresa::PORCASAHOTEL
          cantidad = @carta_actual.valor
          numero_total = @jugador_actual.cuantas_casas_hoteles_tengo
          @jugador_actual.modificar_saldo((cantidad*numeroTotal))
          if @jugador_actual.saldo<=0
            set_estado_juego(EstadoJuego::ALGUNJUGADORENBANCARROTA)
          end
        elsif  @carta_actual.tipo == TipoSorpresa::PORJUGADOR
          @jugadores.each do|jugador|
            if(jugador!=@jugador_actual)
              jugador.modificar_saldo((-@carta_actual.valor))
            end
            if jugador.saldo<=0
              set_estado_juego(EstadoJuego::ALGUNJUGADORENBANCARROTA)
            end
            @jugador_actual.modificar_saldo(@carta_actual.valor)
            if @jugador_actual.saldo<=0
              set_estado_juego(EstadoJuego::ALGUNJUGADORENBANCARROTA)
            end
          end
        elsif @carta_actual.tipo == TipoSorpresa::CONVERTIRME
          especulador = @jugador_actual.convertirme(@carta_actual.valor)
          @jugadores[@jugadores.index(@jugador_actual)] = especulador
          @jugador_actual = especulador
        end
      end
    end
    
    def cancelar_hipoteca(numero_casilla)
      cancelada = false;
      casilla = @tablero.obtener_casilla_numero(numero_casilla)
      titulo = casilla.titulo
      cancelada = @jugador_actual.cancelar_hipoteca(titulo)
      set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      return cancelada
    end
    
    def comprar_titulo_propiedad
      comprado = @jugador_actual.comprar_titulo_propiedad
      if comprado
        set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      end
      return comprado
    end
    
    def edificar_casa(numeroCasilla)
      edificada = false
      casilla = @tablero.obtener_casilla_numero(numeroCasilla)
      titulo = casilla.titulo
      edificada = @jugador_actual.edificar_casa(titulo)
      if edificada
        set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      end
    end
    
    def edificar_hotel(numeroCasilla)
      edificada = false
      casilla = @tablero.obtener_casilla_numero(numeroCasilla)
      titulo = casilla.titulo
      edificada = @jugador_actual.edificar_hotel(titulo)
      if edificada
        set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      end
    end
    
    def encarcelar_jugador
      if !@jugador_actual.tengo_carta_libertad
        casilla_carcel = @tablero.get_carcel
        @jugador_actual.ir_a_carcel(casilla_carcel)
        set_estado_juego(EstadoJuego::JA_ENCARCELADO)
      else
        carta = @jugador_actual.devolver_carta_libertad
        @mazo<< carta
        set_estado_juego(EstadoJuego::JA_PUEDEGESTIONAR)
      end
    end
    
    def valor_dado
      return @dado.valor
    end
    
    def hipotecar_propiedad(numero_casilla)
      casilla = @tablero.obtener_casilla_numero(numero_casilla)
      titulo = casilla.titulo
      @jugador_actual.hipotecar_propiedad(titulo)
    end
    
    def inicializar_cartas_sorpresa
      @mazo = Array.new
      @mazo<< Sorpresa.new("Parece que invertir en criptomonedas te ha salido rentable, ganas 500 euros.", 500, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("La criptomoneda ha caido. Ups. Pierdes 400 euros", -400, TipoSorpresa::PAGARCOBRAR)
      @mazo<< Sorpresa.new("Dia de la marmota. Vuelve a la salida.", 0, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Tienes que comprar tomates en el Mercadona. Ve al Parking.", 12, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Te han pillado haciendo el dab en publico, das 
                          tanto cringe que te meten en la carcel.", 6, TipoSorpresa::IRACASILLA)
      @mazo<< Sorpresa.new("Pagas 50 euros por cada casa u hotel, porque la vida es asi de injusta", -50, TipoSorpresa::PORCASAHOTEL)
      @mazo<< Sorpresa.new("Explota la burbuja, inundando tus propiedades. Ahora son spas. Ganas 50 por cada casa u hotel.", 50, TipoSorpresa::PORCASAHOTEL)
      @mazo<< Sorpresa.new("Hoy te sientes comunista, y decides compartir la alegria del dinero entre todos tus amienemigos.
                            Le regalas 100 euros a cada jugador", -10, TipoSorpresa::PORJUGADOR)
      @mazo<< Sorpresa.new("Compras un aspirador mu tocho. Robas 10 euros a cada jugador.", 10, TipoSorpresa::PORJUGADOR)
      @mazo<< Sorpresa.new("Practicas tus mortales hacia atras hasta que puedes saltar muros. Sales de la carcel.", 0, TipoSorpresa::SALIRCARCEL)
      @mazo<< Sorpresa.new("Los rumores dicen que eres la repera en lo que consta especular. Ahora eres un Especulador 3000.", 3000, TipoSorpresa::CONVERTIRME)
      @mazo<< Sorpresa.new("Los rumores dicen que eres la repera en lo que consta especular. Ahora eres un Especulador 5000.", 5000, TipoSorpresa::CONVERTIRME)
    end  
    
    def inicializar_tablero
      @tablero = Tablero.new
      @dado = Dado.instance
    end
    
    def inicializar_jugadores(nombres)
      nombres.each do |nom|
        jugadores << Jugador.new(nom)
      end
    end
    
    def inicializar_juego(nombres)
      inicializar_jugadores(nombres)
      inicializar_tablero
      inicializar_cartas_sorpresa
      salida_jugadores
      
      @jugador_actual = @jugadores.at(0)
    end
    
    def intentar_salir_carcel(metodo)
      if metodo == MetodoSalirCarcel::TIRANDODADO
        resultado = tirar_dado()
        if resultado >= 5
          @jugador_actual.set_encarcelado(false);
        end
      elsif metodo == MetodoSalirCarcel::PAGANDOLIBERTAD
        @jugador_actual.pagar_libertad(PRECIO_LIBERTAD)
      end
      
      encarcelado = @jugador_actual.encarcelado
      if encarcelado
        set_estado_juego(EstadoJuego::JA_ENCARCELADO)
      else
        set_estado_juego(EstadoJuego::JA_PREPARADO)
      end
      return !encarcelado
    end
    
    def jugar
      valor = tirar_dado
      casilla_final = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, valor)
      mover(casilla_final.numero_casilla)
    end
    
    def mover(num_casilla_destino)
      casilla_inicial = @jugador_actual.casilla_actual
      casilla_final = @tablero.obtener_casilla_numero(num_casilla_destino)
      @jugador_actual.casilla_actual = casilla_final
      
      puts "El jugador " << @jugador_actual.nombre << "se mueve a la casilla " << num_casilla_destino.to_s
      if num_casilla_destino < casilla_inicial.numero_casilla
        @jugador_actual.modificar_saldo(@@SALDO_SALIDA)
      end
      
      if casilla_final.soy_edificable
        actuar_si_en_casilla_edificable
      else
        actuar_si_en_casilla_no_edificable
      end
    end
    
    def obtener_casilla_jugador_actual
      return @jugador_actual.casilla_actual
    end
    
    def obtener_casillas_tablero
      raise NotImplementedError
    end
    
    def obtener_propiedades_jugador
      num_propiedades = ArrayList.new
      for i in 0..@jugador_actual.propiedades.count-1 do
        encontrado=false
        for i in 0..@tablero.casillas.count-1 and !encontrado do
          if(@jugador_actual.propiedades[i]==@tablero.casillas[j].titulo)
            num_propiedades << @tablero.casillas[j].numero_casilla
            encontrado=true
          end
        end
      end
      return num_propiedades
    end
    
    def obtener_propiedades_jugador_segun_estado_hipoteca
      num_propiedades = ArrayList.new
      for i in 0..@jugador_actual.propiedades.count-1 do
        encontrado=false
        for i in 0..@tablero.casillas.count-1 and !encontrado do
          if(@jugador_actual.propiedades[i]==@tablero.casillas[j].titulo and @jugador_actual.propiedades[j].hipotecada == estado_hipoteca)
            num_propiedades << @tablero.casillas[j].numero_casilla
            encontrado=true
          end
        end
      end
      return num_propiedades
    end
    
    def obtener_ranking
      ranking = Array.new
      for jugador in @jugadores
        capital = jugador.obtener_capital
        ranking<<[jugador.nombre,capital]
      end
      return ranking
    end
    
    def obtener_saldo_jugador_actual
      return @jugador_actual.saldo
    end
    
    def salida_jugadores
      @jugadores.each do |jugador|
        jugador.casilla_actual = @tablero.obtener_casilla_numero(0)
      end
      
      valor = Random.new
      @numero_jugador_actual = valor.rand(@jugadores.count-1)
      @jugador_actual = @jugadores[@numero_jugador_actual]
      
      set_estado_juego(EstadoJuego::JA_PREPARADO)
    end
    
    def set_estado_juego(estado_juego)
      @estado_juego = estado_juego
    end
    
    def siguiente_jugador
      pos = @jugadores.index(@jugador_actual)
      
      if (pos + 1 == @jugadores.size)
         @jugador_actual = @jugadores[0]
      else
         @jugador_actual = @jugadores[pos + 1]
      end
      
      if @jugador_actual.encarcelado
        set_estado_juego(EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD)
      else
        set_estado_juego(EstadoJuego::JA_PREPARADO)
      end
    end
    
    def tirar_dado
      return @dado.tirar
    end
    
    def vender_propiedad(numero_casilla)
      casilla = @tablero.obtener_casilla_numero(numero_casilla)
      @jugador_actual.vender_propiedad(casilla)
      precio_venta = casilla.titulo.calcular_precio_venta
      @jugador_actual.modificar_saldo(precio_venta)
    end
  end
end
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Jugador
    
  end
  class Especulador < Jugador
    attr_accessor :fianza
    
    def self.copia(un_jugador, fianza)
      super(un_jugador)
      @fianza = fianza
    end

    def pagar_impuesto
      @saldo = @saldo - (@casilla_actual.coste / 2)
    end

    def debo_ir_a_carcel
      return !(pagar_fianza) && !(tengo_carta_libertad)
    end

    def convertirme(fianza)
      return self
    end

    def pagar_fianza
      if (@saldo > @fianza)
        @saldo = @saldo - @fianza
        ret = true
      else
        ret = false
      end

      return ret
    end

    def puedo_edificar_casa(titulo)
      edificable = false
      num_casas = @titulo.num_casas
      if (num_casas < 8)
        edificable = true;
      end
      return edificable
    end

    def puedo_edificar_hotel(titulo)
      edificable = false
      num_casas = @titulo.num_casas
      num_hoteles = @titulo.num_hoteles
      if (num_casas >= 4 && num_hoteles< 8)
        edificable = true;
      end
      return edificable
    end
  end
end

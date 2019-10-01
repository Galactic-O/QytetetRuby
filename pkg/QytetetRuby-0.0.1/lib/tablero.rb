# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative "casilla"
require_relative "calle"
require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModeloQytetet
  class Tablero
    attr_reader :casillas, :carcel
    
   
    def initialize
      iniciarTablero()
    end
    
    def iniciarTablero()
      @casillas = Array.new
      @casillas << Casilla.new(TipoCasilla::SALIDA, 0, 0)
      titulo = TituloPropiedad.new("Calle Champinon", 600, 60, 10, 300, 400)
      @casillas << Calle.new(1, titulo)
      titulo = TituloPropiedad.new("Barrio Hyrule", 600, 60, 10, 300, 400)
      @casillas << Calle.new(2, titulo)
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 3, 0)
      titulo = TituloPropiedad.new("Avenida Alola", 600, 60, 10, 300, 400)
      @casillas << Calle.new(4, titulo)
      
      @casillas << Casilla.new(TipoCasilla::CARCEL, 5, 0)
      
      titulo = TituloPropiedad.new("Calle Inalambrica", 600, 60, 10, 300, 400)
      @casillas << Calle.new(6, titulo)
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 7, 0)
      titulo = TituloPropiedad.new("Vertedero Ruby", 600, 60, 10, 300, 400)
      @casillas << Calle.new(8, titulo)
      titulo = TituloPropiedad.new("Callejon DeepWeb", 600, 60, 10, 300, 400)
      @casillas << Calle.new(9, titulo)
      
      @casillas << Casilla.new(TipoCasilla::PARKING, 10, 0)
      
      titulo = TituloPropiedad.new("Avenida Chicle", 600, 60, 10, 300, 400)
      @casillas << Calle.new(11, titulo)
      @casillas << Casilla.new(TipoCasilla::IMPUESTO, 12, 300)
      titulo = TituloPropiedad.new("Urbanizacion Bocadillo", 600, 60, 10, 300, 400)
      @casillas << Calle.new(13, titulo)
      titulo = TituloPropiedad.new("Hotel Frusfrus", 600, 60, 10, 300, 400)
      @casillas << Calle.new(14, titulo)
      
      @casillas << Casilla.new(TipoCasilla::JUEZ, 15, 0)
      
      titulo = TituloPropiedad.new("Calle Sin Ideas", 600, 60, 10, 300, 400)
      @casillas << Calle.new(16, titulo)
      titulo = TituloPropiedad.new("Acera Copiapega", 600, 60, 10, 300, 400)
      @casillas << Calle.new(17, titulo)
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 18, 0)
      titulo = TituloPropiedad.new("Calle Homicidio", 600, 60, 10, 300, 400)
      @casillas << Calle.new(19, titulo)
      
      @carcel = @casillas[6]
    end
    
  
    public
    def to_s
      #puts  "Hola mundo"
      return "Tablero: \n--Casillas--\n#{@casillas.join} \n--Carcel--\n#{@carcel}"
    end
    
    def obtener_casilla_final(casilla, desplazamiento)
      destino = (casilla.numero_casilla + desplazamiento) % 20
      return @casillas[destino]
    end
    
    def obtener_casilla_numero(numero_casilla)
      return @casillas[numero_casilla] 
    end

    def es_casilla_carcel(numero_casilla)
      c = @casillas[numero_casilla]
      return (c == @carcel)
    end
    
  end
end

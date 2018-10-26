# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative "casilla"
require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModeloQytetet
  class Tablero
    attr_reader :casillas, :carcel
    
   
    def initialize
      @casillas = Array.new
      iniciarTablero()
    end
    
    def iniciarTablero()
      @casillas << Casilla.new(TipoCasilla::SALIDA, 0, 0, nil)
      titulo = TituloPropiedad.new("Calle Champinon", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 1, titulo)
      titulo = TituloPropiedad.new("Barrio Hyrule", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 2, titulo)
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 0, 3, nil)
      titulo = TituloPropiedad.new("Dreamland", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 3, titulo)
      titulo = TituloPropiedad.new("Avenida Alola", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 4, titulo)
      
      @casillas << Casilla.new(TipoCasilla::CARCEL, 0, 6, nil)
      
      titulo = TituloPropiedad.new("Barrio SJW", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 7, titulo)
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 0, 8, nil)
      titulo = TituloPropiedad.new("Vertedero 4Chan", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 9, titulo)
      titulo = TituloPropiedad.new("Calle Los Furros", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 10, titulo)
      titulo = TituloPropiedad.new("Calle DeepWeb", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 11, titulo)
      
      @casillas << Casilla.new(TipoCasilla::PARKING, 0, 12, nil)
      
      titulo = TituloPropiedad.new("Avenida Chicle", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 13, titulo)
      titulo = TituloPropiedad.new("Callejon Galleta", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 14, titulo)
      @casillas << Casilla.new(TipoCasilla::IMPUESTO, 50, 15, nil)
      titulo = TituloPropiedad.new("Urbanizacion Bocadillo", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 16, titulo)
      titulo = TituloPropiedad.new("Hotel Frusfrus", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 17, titulo)
      
      @casillas << Casilla.new(TipoCasilla::JUEZ, 0, 18, nil)
      
      titulo = TituloPropiedad.new("Calle Sin Ideas", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 19, titulo)
      titulo = TituloPropiedad.new("Acera Copiapega", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 20, titulo)
      titulo = TituloPropiedad.new("Barrio Corregido", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 21, titulo)
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 0, 22, nil)
      titulo = TituloPropiedad.new("Calle Homicidio", 600, 60, 10, 300, 400)
      @casillas << Casilla.new(TipoCasilla::CALLE, titulo.precioCompra, 23, titulo)
      
      @carcel = @casillas[6]
    end
    
  
    public
    def to_s
      #puts  "Hola mundo"
      return "Tablero: \n--Casillas--\n#{@casillas.join} \n--Carcel--\n#{@carcel}"
    end
    
    def obtener_casilla_final(casilla, desplazamiento)
      raise NotImplementedError 
    end
    
    def obtener_casilla_numero(numero_casilla)
      raise NotImplementedError 
    end
    
  end
end

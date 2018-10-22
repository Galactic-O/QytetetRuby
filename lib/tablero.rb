# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative "casilla"
require_relative "titulo_propiedad"

module ModeloQytetet
  class Tablero
    attr_reader :casillas, :carcel
    
    @casillas = Array.new
    
    def self.iniciarTablero()
      @casillas << Casilla.newSalida(0)
      
      titulo = TituloPropiedad.new("Calle Champinon", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(1, titulo)
      titulo = TituloPropiedad.new("Barrio Hyrule", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(2, titulo)
      @casillas << Casilla.newSorpresa(3)
      titulo = TituloPropiedad.new("Dreamland", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(4, titulo)
      titulo = TituloPropiedad.new("Avenida Alola", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(5, titulo)
      
      @casillas<< Casilla.newCarcel(6)
      
      titulo = TituloPropiedad.new("Barrio SJW", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(7, titulo)
      @casillas << Casilla.newSorpresa(8)
      titulo = TituloPropiedad.new("Vertedero 4Chan", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(9, titulo)
      titulo = TituloPropiedad.new("Calle Los Furros", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(10, titulo)
      titulo = TituloPropiedad.new("Calle DeepWeb", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(11, titulo)
      
      @casillas << Casilla.newParking(12)
      
      titulo = TituloPropiedad.new("Avenida Chicle", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(13, titulo)
      titulo = TituloPropiedad.new("Callejon Galleta", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(14, titulo)
      @casillas << Casilla.newImpuesto(15, 100)
      titulo = TituloPropiedad.new("Urbanizacion Bocadillo", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(16, titulo)
      titulo = TituloPropiedad.new("Hotel Frusfrus", 600, 60, 10, 300, 400)
      @casillas << Casilla.newCalle(17, titulo)
      
      @casillas << Casilla.newJuez(18)
      
      titulo = TituloPropiedad.new("Calle Sin Ideas", 600, 60, 10, 300, 400)
      @casillas<< Casilla.newCalle(19, titulo)
      titulo = TituloPropiedad.new("Acera Copiapega", 600, 60, 10, 300, 400)
      @casillas<< Casilla.newCalle(20, titulo)
      titulo = TituloPropiedad.new("Barrio Corregido", 600, 60, 10, 300, 400)
      @casillas<< Casilla.newCalle(21, titulo)
      @casillas<< Casilla.newSorpresa(22)
      titulo = TituloPropiedad.new("Calle Homicidio", 600, 60, 10, 300, 400)
      @casillas<< Casilla.newCalle(23, titulo)
      
      @carcel = @casillas[6]
    end
    
    public
    def to_s
      #puts  "Hola mundo"
      puts "Tablero: \n casillas= #{@casillas} \n cárcel= #{@carcel}"
    end
    
    
    #private :inicializar
  end
end

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla, :coste, :tipo, :titulo
    attr_writer :titulo
    
    def initialize(tipoCasilla, coste, numeroCasilla, tituloPropiedad)
      @tipo = tipoCasilla
      @coste = coste
      @numero_casilla = numeroCasilla
      @titulo = tituloPropiedad
    end
    
    #Por alguna razón la cual desconozco total y completamente, Ruby está atontado
    #y se piensa que estos constructores, preciosos y bien definidos aquí debajo,
    #no están definidos, y se ha puesto como objetivo joderme la vida haciendo que
    #no funciones. Aún así los dejo aquí porque me los he currado.
    def newCalle(numeroCasilla, titulo)
      new(TipoCasilla::CALLE, titulo.precioCompra, numeroCasilla, titulo)
    end
    
    def newImpuesto(numeroCasilla, coste)
      new(TipoCasilla::IMPUESTO, coste, numeroCasilla, nil)
    end
    
    def newSorpresa(numeroCasilla)
      new(TipoCasilla::SORPRESA, 0, numeroCasilla, nil)
    end
    
    def newSalida(numeroCasilla)
      new(TipoCasilla::SALIDA, 0, numeroCasilla, nil)
    end
    
    def newJuez(numeroCasilla)
      new(TipoCasilla::JUEZ, 0, numeroCasilla, nil)
    end
    
    def newParking(numeroCasilla)
      new(TipoCasilla::PARKING, 0, numeroCasilla, nil)
    end
    
    def newCarcel(numeroCasilla)
      new(TipoCasilla::CARCEL, 0, numeroCasilla, nil)
    end
    
    def to_s
      t = "Casilla: #{@numero_casilla}\nCoste de la casilla: #{@coste}\nTipo de casilla: #{@tipo}\nTitulo: "
      unless @titulo == nil
        t+= "\n#{@titulo}\n\n"
      else
        t+="No tiene\n\n"
      end
      return t
    end
  end
end

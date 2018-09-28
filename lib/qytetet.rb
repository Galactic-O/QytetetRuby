# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Qytetet
  @mazo
    
  def mazo
    @mazo
  end

  def inicializarCartasSorpresa
    mazo<< Sorpresa.new("Sube el bitcoin. Ganas 100 euros.", 100, TipoSorpresa:PAGARCOBRAR)
    mazo<< Sorpresa.new("Tienes tanta hambre que te comes tu billete de 100 euros. Ups.", -100, TipoSorpresa:PAGARCOBRAR)
    mazo<< Sorpresa.new("Día de la marmota. Vuelve a la salida.", 1, TipoSorpresa.IRACASILLA)
    mazo<< Sorpresa.new("Tienes que comprar tomates en el Mercadona. Ve al Parking.", 4, TipoSorpresa:IRACASILLA)
    mazo<< Sorpresa.new("Te han pillado haciendo el dab en público, das 
                        tanto cringe que te meten en la cárcel.", 6, TipoSorpresa:IRACASILLA)
    mazo<< Sorpresa.new("Tus casas están infestadas de abejas. Pagas 50 euros por cada casa u hotel.", -50, TipoSorpresa:PORCASAHOTEL)
    mazo<< Sorpresa.new("Explota la burbuja, inundando tus propiedades. Ahora son spas. Ganas 50 por cada casa u hotel.", 50, TipoSorpresa:PORCASAHOTEL)
    mazo<< Sorpresa.new("Los otros jugadores te confunden con una máquina expendedora pr culpa de las drogas. 
                        Te roban 10 euros cada uno.", -10, TipoSorpresa:PORJUGADOR)
    mazo<< Sorpresa.new("Compras un aspirador mu tocho. Robas 10 euros a cada jugador.", 10, TipoSorpresa:PORJUGADOR)
    mazo<< Sorpresa.new("Practicas tus mortales hacia atrás hasta que puedes saltar muros. Sales de la cárcel.", 0, TipoSorpresa:SALIRCARCEL)
  end
end

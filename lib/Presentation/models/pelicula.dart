//Esta clase se encarga de albergar las variables necesarias en cualquier pelicula, tanto Popular como byRated
class Pelicula {
  final String portadaDescripcion;
  final String portadaHome;
  final String nombrePelicula;
  final double popularidad;
  final String idioma;
  final String descripcion;
  final String ano;

  const Pelicula(
      {required this.portadaDescripcion,
      required this.portadaHome,
      required this.nombrePelicula,
      required this.popularidad,
      required this.idioma,
      required this.descripcion,
      required this.ano});
}

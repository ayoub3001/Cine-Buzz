import 'package:animate_do/animate_do.dart';
import 'package:cine_buzz/Presentation/models/pelicula.dart';
import 'package:flutter/material.dart';

import '../../../UI/widgets/popup_sheet.dart';

//Este Widget es el encargado de mostrar las imagenes en el home de las peliculas byRated

class RatedHomeConstructor extends StatelessWidget {
  //Gracias a esto tendremos acceso a las variables de la clase Pelicula, la ponemos como requerido.

  final Pelicula data;
  const RatedHomeConstructor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: GestureDetector(
        //Ejecutamos el showActionSheet para poder visualizar la información detallada de cada pelicula.
        onTap: () => showActionSheet(context, data),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              data.portadaHome,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

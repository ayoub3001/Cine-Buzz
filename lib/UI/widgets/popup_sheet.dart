import 'package:flutter/material.dart';
import '../../Presentation/models/pelicula.dart';

//Esta Widget es el que se encarga de mostrar la información detallada de cada película.
void showActionSheet(context, Pelicula data) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                0.8, // Límite máximo de altura (80% de la altura de la pantalla)
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  height: 5,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 200,
                        width: MediaQuery.of(context).size.width / 3,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            data.portadaDescripcion,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.nombrePelicula,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  data.ano,
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 14),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Idioma: ${data.idioma}",
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 14),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${data.popularidad.toStringAsFixed(1)}/10",
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, bottom: 50),
                  child: Text(
                    data.descripcion,
                    softWrap: true,
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * .8,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.amber,
                    ),
                    child: const Text("Volver",
                        style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

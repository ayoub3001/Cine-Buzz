import 'package:cine_buzz/Presentation/models/errores.dart';
import 'package:cine_buzz/Presentation/models/info_json/rated_json.dart';
import 'package:cine_buzz/Presentation/models/pelicula.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:dio/dio.dart";
import "package:connectivity_plus/connectivity_plus.dart";

import '../../models/constructors/popular_home_constructor.dart';
import '../../models/constructors/rated_home_constructor.dart';
import '../../models/info_json/popular_json.dart';
import 'package:intl/intl.dart';

part 'get_information_state.dart';

class GetInformationCubit extends Cubit<GetInformationState> {
  GetInformationCubit() : super(const GetInformationState(constructor: []));

  final apiKey = dotenv.env["TMDB_API_KEY"].toString();

  //Declaramos las variables con los enlaces sin la key
  final String urlPopular =
      "https://api.themoviedb.org/3/movie/popular?api_key=";
  final String urlRated =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=";
  final String consumeImage = "http://image.tmdb.org/t/p/w500";

  final dio = Dio();

  //Esta lista se usa para guardar los widgets (Las imagenes del home...)
  final List<Widget> listaData = [];

  // En caso de que esta variable sea true se emite la lista de peliculas Popular, si es false el byRated
  bool stateBoolPeliculaList = true;

  //Esta funcion es la encargada de realizar la peticion a la api y recibir la informacion.
  void getInformation(context) async {
    try {
      //Esta variable tiene el resultado del estado del internet
      final connectivityResult = await Connectivity().checkConnectivity();
      //Si no está conectado a internet ejecutamos el error de no conectado a internet
      if (connectivityResult == ConnectivityResult.none) {
        throw Errores.errorNoInternet;
      } else {
        final responsePopular = await dio.get(urlPopular + apiKey);
        final responseRated = await dio.get(urlRated + apiKey);

        //Aqui mandamos al decodificador del json el resultado de la peticion a la API, esto es solamente para trabajar mejor con los datos.
        final responseDecodePopular =
            PopularConstructorJson.fromJson(responsePopular.data);
        final responseDecodeRated =
            RatedConstructorJson.fromJson(responseRated.data);

        final directionPopular = responseDecodePopular.results;
        final directionRated = responseDecodeRated.results;

        //Si el status code de la peticion es igual a 200 pues significa que la peticion ha sido exitosa
        if (responsePopular.statusCode == 200 &&
            responseRated.statusCode == 200) {
          if (stateBoolPeliculaList == true) {
            //Emitimos al GetInformationState el constructor de la informacion de las peliculas Popular
            emit(GetInformationState(
                constructor: constructorIformation(
                    state: true, data: directionPopular)));
          } else {
            //Emitimos al GetInformationState el constructor de la informacion de las peliculas byRated
            emit(GetInformationState(
                constructor:
                    constructorIformation(state: false, data: directionRated)));
          }
        } else {
          //En caso de que hubiese algun problema con la petición se ejecuta este error.
          throw Errores.errorNoConnectWithApi;
        }
      }
    } catch (err) {
      if (err == Errores.errorNoConnectWithApi ||
          err == Errores.errorNoInternet) {
        //ERROR
      } else if (err == Errores.errorNoInternet) {
        //Sin internet
      }
    }
  }

  void sendDataPopular(context) {
    stateBoolPeliculaList = true;
    getInformation(context);
  }

  void sendDataRated(context) {
    stateBoolPeliculaList = false;
    getInformation(context);
  }

  List<Widget> constructorIformation(
      {required bool state, required List data}) {
    final List<Widget> listaData = [];
    var dateFormatter = DateFormat('yyyy-MM-dd');
    for (int index = 0; index < data.length; index++) {
      final direction = data[index];
      final ano = dateFormatter.format(direction.releaseDate);
      listaData.add(state
          ? PopularHomeConstructor(
              data: Pelicula(
                  portadaDescripcion: consumeImage + direction.backdropPath,
                  portadaHome: consumeImage + direction.posterPath,
                  nombrePelicula: direction.title,
                  popularidad: direction.voteAverage,
                  idioma: direction.originalLanguage,
                  descripcion: direction.overview,
                  ano: ano))
          : RatedHomeConstructor(
              data: Pelicula(
                  portadaDescripcion: consumeImage + direction.backdropPath,
                  portadaHome: consumeImage + direction.posterPath,
                  nombrePelicula: direction.title,
                  popularidad: direction.voteAverage,
                  idioma: direction.originalLanguage,
                  descripcion: direction.overview,
                  ano: ano)));
    }

    return listaData;
  }
}

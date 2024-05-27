import 'dart:async';

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

  final String urlPopular =
      "https://api.themoviedb.org/3/movie/popular?api_key=";
  final String urlRated =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=";
  final String consumeImage = "http://image.tmdb.org/t/p/w500";

  final dio = Dio();

  final List<Widget> listaData = [];

  bool stateBoolPeliculaList = true;

  void getInformation(context) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Errores.errorNoInternet;
      } else {
        final responsePopular = await dio.get(urlPopular + apiKey);
        final responseRated = await dio.get(urlRated + apiKey);

        final responseDecodePopular =
            PopularConstructorJson.fromJson(responsePopular.data);
        final responseDecodeRated =
            RatedConstructorJson.fromJson(responseRated.data);

        final directionPopular = responseDecodePopular.results;
        final directionRated = responseDecodeRated.results;

        if (responsePopular.statusCode == 200 &&
            responseRated.statusCode == 200) {
          if (stateBoolPeliculaList == true) {
            emit(GetInformationState(
                constructor: constructorIformation(
                    state: true, data: directionPopular)));
          } else {
            emit(GetInformationState(
                constructor:
                    constructorIformation(state: false, data: directionRated)));
          }
        } else {
          throw Errores.errorNoConnectWithApi;
        }
      }
    } catch (err) {
      if (err == Errores.errorNoConnectWithApi ||
          err == Errores.errorNoInternet) {
        print("NO conexion api");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Hubo un error"),
                content: const Text("Reinice la App porfavor"),
                actions: [
                  FloatingActionButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Volver"),
                  )
                ],
              );
            });
      } else if (err == Errores.errorNoInternet) {
        print("NO conexion internet");

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sin Conexion"),
                content: const Text(
                    "No hay Conexión a Internet, conéctate y vuelve a intentarlo"),
                actions: [
                  FloatingActionButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Volver"),
                  )
                ],
              );
            });
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

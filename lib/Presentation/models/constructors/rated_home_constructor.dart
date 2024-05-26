import 'package:cine_buzz/Presentation/models/pelicula.dart';
import 'package:flutter/material.dart';

class RatedHomeConstructor extends StatelessWidget {
  final Pelicula data;
  const RatedHomeConstructor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Image.network(data.portadaHome);
  }
}

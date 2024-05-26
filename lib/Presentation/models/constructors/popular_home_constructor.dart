import 'package:flutter/material.dart';

import '../pelicula.dart';

class PopularHomeConstructor extends StatelessWidget {
  final Pelicula data;
  const PopularHomeConstructor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Image.network(
        data.portadaHome,
      ),
    );
  }
}

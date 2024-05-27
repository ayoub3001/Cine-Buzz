import 'package:cine_buzz/Presentation/models/pelicula.dart';
import 'package:flutter/material.dart';

import '../../../UI/widgets/popup_sheet.dart';

class RatedHomeConstructor extends StatelessWidget {
  final Pelicula data;
  const RatedHomeConstructor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showActionSheet(context, data);
      },
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
    );
  }
}

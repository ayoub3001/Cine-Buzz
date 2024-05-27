import 'package:flutter/material.dart';

import '../../../UI/widgets/popup_sheet.dart';
import '../pelicula.dart';

class PopularHomeConstructor extends StatelessWidget {
  final Pelicula data;
  const PopularHomeConstructor({super.key, required this.data});

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

import 'package:animate_do/animate_do.dart';
import 'package:cine_buzz/Presentation/Bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Esta clase se encarga de recibir la informacion del GetInformationState y mostrarlo por pantalla
class BuildingInformation extends StatefulWidget {
  const BuildingInformation({super.key});

  @override
  State<BuildingInformation> createState() => _BuildingInformationState();
}

class _BuildingInformationState extends State<BuildingInformation> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetInformationCubit, GetInformationState>(
          builder: (context, state) {
        if (state.constructor.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              children: [
                for (Widget widget in state.constructor)
                  FadeInUpBig(child: widget)
              ],
            ),
          );
        } else {
          return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()]);
        }
      }),
    );
  }
}

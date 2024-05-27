import 'package:cine_buzz/Presentation/Bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [for (Widget widget in state.constructor) widget],
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

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
    return BlocBuilder<GetInformationCubit, GetInformationState>(
        builder: (context, state) {
      return SizedBox(
        height: 200,
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: [for (Widget widget in state.constructor) widget]),
      );
    });
  }
}

import 'package:cine_buzz/Presentation/Bloc/cubit/get_information_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Presentation/models/variables.dart';
import 'building_information.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  bool stateIcon1 = true;
  bool stateIcon2 = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF0F0F0),
        body: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: colorGrisFondos,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: const Center(
                child: Text(
                  "FIND AND ENJOY YOUR MOVIE",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "FILTERS",
                style: TextStyle(
                    color: colorGrisText,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        stateIcon1 = true;
                        stateIcon2 = false;
                      });

                      context
                          .read<GetInformationCubit>()
                          .sendDataPopular(context);
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: colorGrisFondos,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: stateIcon1 == true
                            ? const Icon(
                                Icons.check,
                                color: Colors.amber,
                              )
                            : const SizedBox()),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 5, right: 50),
                    child: const Text("Popular"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        stateIcon1 = false;
                        stateIcon2 = true;
                      });

                      context
                          .read<GetInformationCubit>()
                          .sendDataRated(context);
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: colorGrisFondos,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: stateIcon2 == true
                            ? const Icon(
                                Icons.check,
                                color: Colors.amber,
                              )
                            : const SizedBox()),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 5, right: 50),
                    child: const Text("Top Rated"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "RESULTS",
                style: TextStyle(
                    color: colorGrisText,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Colors.amber,
            ),
            const BuildingInformation()
          ],
        ),
      ),
    );
  }
}

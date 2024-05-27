import 'package:cine_buzz/Presentation/Bloc/bloc.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'UI/screens/page_home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyBlocProvider());
}

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => GetInformationCubit()..sendDataPopular(context))
    ], child: const PageHome());
  }
}

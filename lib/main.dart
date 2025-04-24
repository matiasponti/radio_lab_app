import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart';
import 'presentation/bloc/radio_list_bloc/radio_list_bloc.dart';
import 'presentation/pages/radio_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const RadioLabApp());
}

class RadioLabApp extends StatelessWidget {
  const RadioLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadioListBloc>()..add(LoadStationsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Radio App',
        theme: ThemeData.dark(),
        home: const RadioHomePage(),
      ),
    );
  }
}

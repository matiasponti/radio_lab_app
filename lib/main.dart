import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_event.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/theme/app_theme.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => sl<RadioListBloc>()..add(LoadStationsEvent())),
        BlocProvider(create: (_) => sl<PlayerBloc>()),
        BlocProvider(create: (_) => FavoritesBloc()..add(LoadFavoritesEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Radio Lab App',
        theme: AppTheme.darkTheme,
        home: const RadioHomePage(),
      ),
    );
  }
}

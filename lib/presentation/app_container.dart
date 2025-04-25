import 'package:flutter/material.dart';
import 'package:radio_lab_app/presentation/pages/radio_home_page.dart';
import 'package:radio_lab_app/presentation/widgets/mini_player.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Navigator para manejar la navegación entre pantallas
        Navigator(
          initialRoute: '/',
          onGenerateRoute: (settings) {
            late Widget page;

            switch (settings.name) {
              case '/':
                page = const RadioHomePage();
                break;
              default:
                page = settings.arguments as Widget;
            }

            return MaterialPageRoute(builder: (_) => page, settings: settings);
          },
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Material(
            elevation: 6,
            color: Colors.transparent,
            child: MiniPlayer(),
          ),
        ),
      ],
    );
  }
}

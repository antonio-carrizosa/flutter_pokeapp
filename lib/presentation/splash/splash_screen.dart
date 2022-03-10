import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/splash/splash_state.dart';
import 'package:pokeapp/presentation/splash/widgets/error.dart';
import 'package:pokeapp/presentation/splash/widgets/loading.dart';
import 'package:pokeapp/presentation/home/home.dart';

import 'package:pokeapp/providers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (_, ref, __) {
            ref.listen<SplashState>(splashStateNotifier, (_, next) {
              if (next is Loaded) {
                ref.read(homeStateNotifier.notifier).addPokemons(next.results);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              }
            });

            final state = ref.watch(splashStateNotifier);
            if (state is Error) {
              print(state);
              return CustomErrorWidget(
                text: "No se pudo extablecer conexion con el servidor.",
                retry: ref.read(splashStateNotifier.notifier).retry,
              );
            }

            return const LoadingWidget(
              text: "Cargando \n Por favor espere.",
            );
          },
        ),
      ),
    );
  }
}

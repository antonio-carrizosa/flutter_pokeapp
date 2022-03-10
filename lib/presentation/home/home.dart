import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/home/home_state.dart';
import 'package:pokeapp/presentation/home/widgets/poke_list.dart';
import 'package:pokeapp/providers.dart';

class Home extends HookWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Poke App"),
      ),
      body: Consumer(
        builder: (_, ref, __) {
          final state = ref.watch(homeStateNotifier);
          final pokemons = state.pokemons;

          ref.listen<HomeState>(homeStateNotifier, (prevState, newState) {
            newState.failureOption.fold(() {}, (f) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error al obtener mas pokemon.")));
              ref.read(homeStateNotifier.notifier).clearError();
            });
          });

          return Column(
            children: [
              Expanded(
                child: PokeList(
                  pokemons: pokemons,
                  loadMore:
                      ref.read(homeStateNotifier.notifier).getMorePokemons,
                ),
              ),
              if (state.loading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}

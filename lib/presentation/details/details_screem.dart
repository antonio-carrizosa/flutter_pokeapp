import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/presentation/details/widgets/info_bg.dart';
import 'package:pokeapp/presentation/details/widgets/pokemon_details.dart';
import 'package:pokeapp/presentation/details/widgets/profile.dart';
import 'package:pokeapp/providers.dart';

class DetailsScreen extends StatelessWidget {
  final int id;
  final Result pokemon;
  const DetailsScreen({
    Key? key,
    required this.id,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Profile(id: id, pokemon: pokemon),
          InfoBg(
            child: Consumer(
              builder: (_, ref, __) {
                return ref.watch(getPokemon.call(id)).maybeWhen(
                      data: (Either<Failure, Pokemon> failureOrSuccess) {
                        return failureOrSuccess.fold(
                          (Failure f) => const Center(
                            child: Text("Error"),
                          ),
                          (Pokemon pokemon) {
                            return PokemonDetails(pokemon: pokemon);
                          },
                        );
                      },
                      orElse: () =>
                          const Center(child: CircularProgressIndicator()),
                    );
              },
            ),
          ),
        ],
      )),
    );
  }
}

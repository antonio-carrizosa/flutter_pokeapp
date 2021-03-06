import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/presentation/details/widgets/info_bg.dart';
import 'package:pokeapp/presentation/details/widgets/pokemon_details.dart';
import 'package:pokeapp/presentation/details/widgets/profile.dart';
import 'package:pokeapp/presentation/utils/snackbar.dart';
import 'package:pokeapp/providers.dart';

class DetailsScreen extends StatelessWidget {
  final Result result;
  const DetailsScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          // Shows the pokemon's id, name and image;
          Profile(id: result.id, pokemon: result),
          InfoBg(
            child: Consumer(
              builder: (_, ref, __) {
                // I decide to use the FutureProviderFamily that comes with Riverpod
                // instead of a FutureBuilder because it has an union for handle every
                // case. I don't handle the error function because the error comes
                // in the regular data flow.
                return ref.watch(getPokemon.call('${result.id}')).maybeWhen(
                      data: (Either<Failure, Pokemon> failureOrSuccess) {
                        return failureOrSuccess.fold(
                          (Failure f) => Center(
                            child: Text(getFailureMessage(f)),
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

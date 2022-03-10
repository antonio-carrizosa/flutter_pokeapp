import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/extensions/x_capitalize.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/providers.dart';

final spriteBaseUrl = dotenv.env['SPRITE_URL'];

class PokemonDetails extends StatelessWidget {
  final int id;
  final Result pokemon;
  const PokemonDetails({
    Key? key,
    required this.id,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name.capitalize())),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: Hero(
                tag: pokemon.name,
                child: Image.network('$spriteBaseUrl/$id.png'),
              ),
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              return ref.watch(getPokemon.call(id)).maybeWhen(
                    data: (Either<Failure, Pokemon> failureOrSuccess) {
                      return failureOrSuccess.fold(
                        (Failure f) => const Center(
                          child: Text("Error"),
                        ),
                        (Pokemon pokemon) {
                          print(pokemon);
                          return Container();
                        },
                      );
                    },
                    orElse: () => const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
            },
          ),
        ],
      )),
    );
  }
}

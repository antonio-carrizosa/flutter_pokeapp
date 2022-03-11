import 'package:flutter/material.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/presentation/details/widgets/info_item.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoItem(field: "Height:", value: '${pokemon.height}'),
            InfoItem(field: "Weight:", value: '${pokemon.weight}'),
            const Divider(),
            const Text(
              "Types",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: pokemon.types
                  .map((t) => Chip(label: Text(t.type.name)))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/presentation/details/widgets/info_item.dart';
import 'package:pokeapp/presentation/details/widgets/stat.dart';
import 'package:pokeapp/presentation/utils/type_colors.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Basic pokemon info, i couldn't find the unit metric
              // used for height and weight
              InfoItem(field: "Height:", value: '${pokemon.height}'),
              InfoItem(field: "Weight:", value: '${pokemon.weight}'),
              const Divider(),
              const Text(
                "Types",
                style: TextStyle(fontSize: 18),
              ),
              // Display a chip for the type of pokemon [normal, grass, poison ....]
              // with the color type identifier
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.types
                    .map((t) => Chip(
                          backgroundColor: typeColors[t.type.name],
                          label: Text(
                            t.type.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList(),
              ),
              const Divider(),
              // Display the pokemon stats, i use a progressbar to show a visual
              // representation of pokemon's baseStat
              Column(
                  children: pokemon.stats.map((s) {
                return StatWidget(s: s);
              }).toList())
            ],
          ),
        ],
      ),
    );
  }
}

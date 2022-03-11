import 'package:flutter/material.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/presentation/details/widgets/info_item.dart';
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

class StatWidget extends StatelessWidget {
  final Stat s;
  const StatWidget({Key? key, required this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.stat.name.toUpperCase(),
              ),
              Text(
                '${s.baseStat}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
            child: LinearProgressIndicator(
          value: s.baseStat / 100,
        )),
      ],
    );
  }
}

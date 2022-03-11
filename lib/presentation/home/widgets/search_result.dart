import 'package:flutter/material.dart';

import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/extensions/x_capitalize.dart';

class SearchResult extends StatelessWidget {
  final Pokemon pokemon;
  final void Function() onTap;

  const SearchResult({Key? key, required this.pokemon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8),
        tileColor: Theme.of(context).primaryColor,
        trailing: FadeInImage(
          image: NetworkImage(pokemon.asset),
          placeholder: const AssetImage('assets/pokeball.png'),
        ),
        title: Text(
          '#${pokemon.id} ${pokemon.name.capitalize()}',
          style: style,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

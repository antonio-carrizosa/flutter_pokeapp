import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/presentation/details/pokemon_details.dart';
import 'package:pokeapp/presentation/home/widgets/poke_list_item.dart';

class PokeList extends HookWidget {
  final List<Result> pokemons;
  final void Function() loadMore;
  const PokeList({Key? key, required this.pokemons, required this.loadMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          //TODO: Corregir el numero de peticiones
          loadMore();
        }
      });
      return () {};
    }, []);

    return ListView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        final pokemon = pokemons[index];
        return PokeListItem(
          pokemon: pokemon,
          id: index + 1,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PokemonDetails(
                    id: index + 1,
                    pokemon: pokemon,
                  ),
                ));
          },
        );
      },
    );
  }
}

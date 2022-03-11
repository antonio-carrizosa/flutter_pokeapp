import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/presentation/details/details_screen.dart';
import 'package:pokeapp/presentation/home/widgets/poke_list_item.dart';

class PokeList extends HookWidget {
  final List<Result> pokemons;
  final void Function() loadMore;
  final void Function(int id) deletePokemon;
  const PokeList(
      {Key? key,
      required this.pokemons,
      required this.loadMore,
      required this.deletePokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
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
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(
                    pokemon: pokemon,
                  ),
                ));
          },
          delete: () => deletePokemon(pokemon.id),
        );
      },
    );
  }
}

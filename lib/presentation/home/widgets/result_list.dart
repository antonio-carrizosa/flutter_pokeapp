import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/presentation/details/details_screen.dart';
import 'package:pokeapp/presentation/home/widgets/result_list_item.dart';

class ResultList extends HookWidget {
  final List<Result> results;
  final void Function() loadMore;
  final void Function(int id) deletePokemon;
  const ResultList(
      {Key? key,
      required this.results,
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
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        final pokemon = results[index];
        return ResultListItem(
          result: pokemon,
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(
                    result: pokemon,
                  ),
                ));
          },
          delete: () => deletePokemon(pokemon.id),
        );
      },
    );
  }
}

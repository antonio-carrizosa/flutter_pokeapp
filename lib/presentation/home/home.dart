import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/home/home_state.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/presentation/details/details_screen.dart';
import 'package:pokeapp/presentation/home/widgets/custom_search_bar.dart';
import 'package:pokeapp/presentation/home/widgets/result_list.dart';
import 'package:pokeapp/presentation/home/widgets/search_result.dart';
import 'package:pokeapp/presentation/utils/snackbar.dart';
import 'package:pokeapp/providers.dart';

class Home extends ConsumerWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeStateNotifier);
    final notifier = ref.read(homeStateNotifier.notifier);
    final results = state.results;

    ref.listen<HomeState>(homeStateNotifier, (_, newState) {
      newState.failureOption.fold(() {}, (f) {
        showSnackBar(context, f);
        ref.read(homeStateNotifier.notifier).clearError();
      });
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Poke App"),
      ),
      body: Column(
        children: [
          CustomSearchBar(search: notifier.searchPokemon),
          if (state.searching)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          if (state.founded != null)
            SearchResult(
              pokemon: state.founded!,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetailsScreen(
                      result: Result(
                          id: state.founded!.id, name: state.founded!.name)),
                ));
              },
            ),
          if (!state.searching && state.founded == null)
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ResultList(
                      results: results,
                      loadMore: notifier.loadMoreResults,
                      deletePokemon: notifier.deletePokemon,
                    ),
                  ),
                  if (state.loading)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: notifier.refresh,
        child: Icon(
          Icons.refresh,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

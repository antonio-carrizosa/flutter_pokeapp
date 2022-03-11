import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/splash/splash_state.dart';
import 'package:pokeapp/presentation/splash/widgets/error.dart';
import 'package:pokeapp/presentation/splash/widgets/loading.dart';
import 'package:pokeapp/presentation/home/home.dart';
import 'package:pokeapp/presentation/utils/snackbar.dart';

import 'package:pokeapp/providers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          // Note: Use freezed's unions for an behaviour like
          // kotlin's Sealed Classes to avoid if statements
          builder: (_, ref, __) {
            ref.listen<SplashState>(splashStateNotifier, (_, next) {
              // Replace the current page with the Home page
              // when the request has been successful.
              if (next is Loaded) {
                ref.read(homeStateNotifier.notifier).addResults(next.results);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              }
            });

            final state = ref.watch(splashStateNotifier);
            // Displays the error when the request has failed.
            if (state is Error) {
              return CustomErrorWidget(
                text: getFailureMessage(state.failure),
                retry: ref.read(splashStateNotifier.notifier).retry,
              );
            }
            // Because in this point i don't need parameters
            // is the default return.
            return const LoadingWidget(
              text: "Loading \n Please wait.",
            );
          },
        ),
      ),
    );
  }
}

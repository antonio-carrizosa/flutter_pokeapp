import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomSearchBar extends HookWidget {
  final void Function(String term) search;
  const CustomSearchBar({
    Key? key,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    Timer? timer;

    // Handles the user input, it works with a delay so when the user has left
    // tyiping calls the search method received by parameter
    useEffect(() {
      textController.addListener(() {
        final text = textController.text;
        if (timer != null) {
          timer?.cancel();
        }
        timer = Timer(const Duration(milliseconds: 500), () {
          search(text);
        });
      });

      return () {};
    }, []);

    final clear = textController.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        autofocus: false,
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            hintText: "Search by pokemon id or name.",
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            filled: true,
            fillColor: const Color(0XFFFFCC00),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: clear
                ? IconButton(
                    onPressed: textController.clear,
                    icon: const Icon(Icons.close),
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
    );
  }
}

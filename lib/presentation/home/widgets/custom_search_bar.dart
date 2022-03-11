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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        autofocus: false,
        decoration: InputDecoration(
            hintText: "Search by pokemon id or name.",
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            filled: true,
            fillColor: const Color(0XFFFFCC00),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            )),
      ),
    );
  }
}

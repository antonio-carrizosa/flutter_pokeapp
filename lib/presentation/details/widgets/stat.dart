import 'package:flutter/material.dart';
import 'package:pokeapp/core/models/stat.dart';

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

import 'package:flutter/material.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/extensions/x_capitalize.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final spriteBaseUrl = dotenv.env['SPRITE_URL'];

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.id,
    required this.pokemon,
  }) : super(key: key);

  final int id;
  final Result pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '#$id',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Text(
              pokemon.name.capitalize(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 150,
          child: Hero(
            tag: pokemon.name,
            child: Image.network('$spriteBaseUrl/$id.png'),
          ),
        ),
      ],
    );
  }
}

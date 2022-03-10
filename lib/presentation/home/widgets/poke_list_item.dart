import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokeapp/extensions/x_capitalize.dart';
import 'package:pokeapp/core/models/result.dart';

final spriteBaseUrl = dotenv.env['SPRITE_URL'];

class PokeListItem extends StatelessWidget {
  final Result pokemon;
  final int id;
  final void Function() onTap;

  const PokeListItem({
    Key? key,
    required this.pokemon,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: InkWell(
            onTap: onTap,
            child: Background(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Hero(
                          tag: pokemon.name,
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/pokeball.png'),
                            image: NetworkImage('$spriteBaseUrl/$id.png'),
                            imageErrorBuilder: (_, __, ___) {
                              return Image.asset('$spriteBaseUrl/$id.png');
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      pokemon.name.capitalize(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        //TODO: Implementar eliminar
                        print("delete");
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Color(0XFFFFCC00),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
    /* Image.network('$spriteBaseUrl/${index + 1}.png'), */
  }
}

class Background extends StatelessWidget {
  const Background({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}

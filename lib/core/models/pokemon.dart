import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokeapp/core/models/stat.dart';
import 'package:pokeapp/core/models/type.dart';

class Pokemon {
  Pokemon(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.stats,
      required this.types});

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<Stat> stats;
  final List<Type> types;

  String get asset => '${dotenv.env['SPRITE_URL']}/$id.png';

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json["height"],
      weight: json["weight"],
      stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
      types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    );
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Pokemon {
  Pokemon(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.types});

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<Type> types;

  String get asset => '${dotenv.env['SPRITE_URL']}/$id.png';

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json["height"],
      weight: json["weight"],
      types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    );
  }
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  Species type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

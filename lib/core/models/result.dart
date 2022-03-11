import 'package:flutter_dotenv/flutter_dotenv.dart';

class Result {
  Result({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  String get asset => '${dotenv.env['SPRITE_URL']}/$id.png';

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(name: json["name"], id: 0);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Result copyWith({
    int? id,
    String? name,
    String? url,
  }) {
    return Result(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

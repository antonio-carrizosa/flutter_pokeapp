import 'package:pokeapp/core/models/specie.dart';

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  Species stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

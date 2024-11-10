// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Pokemon> pokemonFromJson(String str) =>
    List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

String pokemonToJson(List<Pokemon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pokemon with EquatableMixin {
  Pokemon({
    required this.dex,
    required this.name,
    this.animationTime,
    required this.height,
    required this.weight,
    required this.maxCp,
    this.buddySize,
    required this.types,
    required this.encounter,
    required this.evolution,
    required this.id,
    this.rarity,
  });

  late int dex;
  late String name;
  List<double>? animationTime;
  late double height;
  late double weight;
  late int maxCp;
  BuddySize? buddySize;
  late List<BuddySize> types;
  late Encounter encounter;
  late Evolution evolution;
  late String id;
  BuddySize? rarity;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        dex: json["dex"],
        name: json["name"],
        height: json["height"].toDouble(),
        weight: json["weight"].toDouble(),
        maxCp: json["maxCP"],
        types: List<BuddySize>.from(
            json["types"].map((x) => BuddySize.fromJson(x))),
        encounter: Encounter.fromJson(json["encounter"]),
        evolution: Evolution.fromJson(json["evolution"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dex": dex,
        "name": name,
        "animationTime": List<dynamic>.from(animationTime!.map((x) => x)),
        "height": height,
        "weight": weight,
        "maxCP": maxCp,
        "buddySize": buddySize?.toJson(),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "encounter": encounter.toJson(),
        "evolution": evolution.toJson(),
        "id": id,
        "rarity": rarity?.toJson(),
      };

  @override
  List<Object?> get props => [
    dex,
    name,
    animationTime,
    height,
    weight,
    maxCp,
    buddySize,
    types,
    encounter,
    evolution,
    id,
    rarity,
  ];

}

class BuddySize {
  BuddySize({
    required this.id,
    required this.name,
  });

  late String id;
  late String name;

  factory BuddySize.fromJson(Map<String, dynamic> json) => BuddySize(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Encounter {
  Encounter({
    this.gender,
  });

  late Gender? gender;

  factory Encounter.fromJson(Map<String, dynamic> json) => Encounter(
        gender: json["gender"] == null ? null : Gender.fromJson(json["gender"]),
      );

  Map<String, dynamic> toJson() => {
        "gender": gender?.toJson(),
      };
}

class Gender {
  Gender({
    required this.malePercent,
    required this.femalePercent,
  });

  late double malePercent;
  late double femalePercent;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        malePercent: json["malePercent"].toDouble(),
        femalePercent: json["femalePercent"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "malePercent": malePercent,
        "femalePercent": femalePercent,
      };
}

class Evolution {
  Evolution({
    this.futureBranches,
    required this.pastBranch,
  });

  late List<FutureBranch>? futureBranches;
  late Branch? pastBranch;

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        futureBranches: json["futureBranches"] == null
            ? null
            : List<FutureBranch>.from(
                json["futureBranches"].map((x) => FutureBranch.fromJson(x))),
        pastBranch: json["pastBranch"] == null
            ? null
            : Branch.fromJson(json["pastBranch"]),
      );

  Map<String, dynamic> toJson() => {
        "futureBranches": futureBranches == null
            ? null
            : List<dynamic>.from(futureBranches!.map((x) => x.toJson())),
        "pastBranch": pastBranch?.toJson(),
      };
}

class FutureBranch {
  FutureBranch({
    required this.name,
    required this.id,
    required this.futureBranches,
  });

  late String name;
  late String id;
  late List<Branch>? futureBranches;

  factory FutureBranch.fromJson(Map<String, dynamic> json) => FutureBranch(
        name: json["name"],
        id: json["id"],
        futureBranches: json["futureBranches"] == null
            ? null
            : List<Branch>.from(
                json["futureBranches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "futureBranches": futureBranches == null
            ? null
            : List<dynamic>.from(futureBranches!.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    required this.name,
    required this.id,
    this.costToEvolve,
    required this.pastBranch,
  });

  late String name;
  late String id;
  late PastBranchCostToEvolve? costToEvolve;
  late BuddySize? pastBranch;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        name: json["name"],
        id: json["id"],
        costToEvolve: json["costToEvolve"] == null
            ? null
            : PastBranchCostToEvolve.fromJson(json["costToEvolve"]),
        pastBranch: json["pastBranch"] == null
            ? null
            : BuddySize.fromJson(json["pastBranch"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "costToEvolve": costToEvolve?.toJson(),
        "pastBranch": pastBranch?.toJson(),
      };
}

class PastBranchCostToEvolve {
  PastBranchCostToEvolve({
    required this.candyCost,
    required this.evolutionItem,
  });

  late int candyCost;
  late BuddySize? evolutionItem;

  factory PastBranchCostToEvolve.fromJson(Map<String, dynamic> json) =>
      PastBranchCostToEvolve(
        candyCost: json["candyCost"],
        evolutionItem: json["evolutionItem"] == null
            ? null
            : BuddySize.fromJson(json["evolutionItem"]),
      );

  Map<String, dynamic> toJson() => {
        "candyCost": candyCost,
        "evolutionItem": evolutionItem?.toJson(),
      };
}

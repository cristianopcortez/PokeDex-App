class MoveDetail {
  late int? accuracy;
  late ContestType? contestType;
  late ContestType? damageClass;
  late int id;
  late List<LearnedByPokemon>? learnedByPokemon;
  late Meta? meta;
  late String name;
  late int? power;
  late int pp;
  late int priority;
  late ContestType type;

  MoveDetail(
      {required this.accuracy,
      required this.contestType,
      required this.damageClass,
      required this.id,
      required this.learnedByPokemon,
      required this.meta,
      required this.name,
      required this.power,
      required this.pp,
      required this.priority,
      required this.type});

  MoveDetail.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    contestType = (json['contest_type'] != null
        ? new ContestType.fromJson(json['contest_type'])
        : null)!;
    damageClass = (json['damage_class'] != null
        ? new ContestType.fromJson(json['damage_class'])
        : null)!;
    id = json['id'];
    if (json['learned_by_pokemon'] != null) {
      learnedByPokemon = <LearnedByPokemon>[];
      json['learned_by_pokemon'].forEach((v) {
        learnedByPokemon?.add(new LearnedByPokemon.fromJson(v));
      });
    }
    meta = (json['meta'] != null ? new Meta.fromJson(json['meta']) : null)!;
    name = json['name'];
    power = json['power'];
    pp = json['pp'];
    priority = json['priority'];
    type = (json['type'] != null ? new ContestType.fromJson(json['type']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    if (this.contestType != null) {
      data['contest_type'] = this.contestType?.toJson();
    }
    if (this.damageClass != null) {
      data['damage_class'] = this.damageClass?.toJson();
    }
    data['id'] = this.id;
    if (this.learnedByPokemon != null) {
      data['learned_by_pokemon'] =
          this.learnedByPokemon?.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta?.toJson();
    }
    data['name'] = this.name;
    data['power'] = this.power;
    data['pp'] = this.pp;
    data['priority'] = this.priority;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class ContestType {
  late String name;

  ContestType({required this.name});

  ContestType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class LearnedByPokemon {
  late String name;
  late String url;

  LearnedByPokemon({required this.name, required this.url});

  LearnedByPokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Meta {
  late int ailmentChance;
  late int critRate;
  late int drain;
  late int flinchChance;
  late int healing;
  late int statChance;

  Meta(
      {required this.ailmentChance,
      required this.critRate,
      required this.drain,
      required this.flinchChance,
      required this.healing,
      required this.statChance});

  Meta.fromJson(Map<String, dynamic> json) {
    ailmentChance = json['ailment_chance'];
    critRate = json['crit_rate'];
    drain = json['drain'];
    flinchChance = json['flinch_chance'];
    healing = json['healing'];
    statChance = json['stat_chance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ailment_chance'] = this.ailmentChance;
    data['crit_rate'] = this.critRate;
    data['drain'] = this.drain;
    data['flinch_chance'] = this.flinchChance;
    data['healing'] = this.healing;
    data['stat_chance'] = this.statChance;
    return data;
  }
}

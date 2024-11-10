class PokemonAPI {
  late int baseExperience;
  late int height;
  late int id;
  late List<Moves> moves;
  late String name;
  late List<Stats> stats;
  late List<Types> types;
  late int weight;

  PokemonAPI(
      {required this.baseExperience,
      required this.height,
      required this.id,
      required this.moves,
      required this.name,
      required this.stats,
      required this.types,
      required this.weight});

  PokemonAPI.fromJson(Map<String, dynamic> json) {
    baseExperience = json['base_experience'];
    height = json['height'];
    id = json['id'];
    if (json['moves'] != null) {
      moves = <Moves>[];
      json['moves'].forEach((v) {
        moves.add(new Moves.fromJson(v));
      });
    }
    name = json['name'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats.add(new Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_experience'] = this.baseExperience;
    data['height'] = this.height;
    data['id'] = this.id;
    if (this.moves != null) {
      data['moves'] = this.moves.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    return data;
  }
}

class Moves {
  late Move move;
  late List<VersionGroupDetails> versionGroupDetails;

  Moves({required this.move, required this.versionGroupDetails});

  Moves.fromJson(Map<String, dynamic> json) {
    move = (json['move'] != null ? new Move.fromJson(json['move']) : null)!;
    if (json['version_group_details'] != null) {
      versionGroupDetails = <VersionGroupDetails>[];
      json['version_group_details'].forEach((v) {
        versionGroupDetails.add(new VersionGroupDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.move != null) {
      data['move'] = this.move.toJson();
    }
    if (this.versionGroupDetails != null) {
      data['version_group_details'] =
          this.versionGroupDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Move {
  late String name;

  Move({required this.name});

  Move.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class VersionGroupDetails {
  late int levelLearnedAt;
  late Move moveLearnMethod;
  late Move versionGroup;

  VersionGroupDetails(
      {required this.levelLearnedAt, required this.moveLearnMethod, required this.versionGroup});

  VersionGroupDetails.fromJson(Map<String, dynamic> json) {
    levelLearnedAt = json['level_learned_at'];
    moveLearnMethod = (json['move_learn_method'] != null
        ? new Move.fromJson(json['move_learn_method'])
        : null)!;
    versionGroup = (json['version_group'] != null
        ? new Move.fromJson(json['version_group'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level_learned_at'] = this.levelLearnedAt;
    if (this.moveLearnMethod != null) {
      data['move_learn_method'] = this.moveLearnMethod.toJson();
    }
    if (this.versionGroup != null) {
      data['version_group'] = this.versionGroup.toJson();
    }
    return data;
  }
}

class Stats {
  late int baseStat;
  late Move stat;

  Stats({required this.baseStat, required this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    stat = (json['stat'] != null ? new Move.fromJson(json['stat']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    if (this.stat != null) {
      data['stat'] = this.stat.toJson();
    }
    return data;
  }
}

class Types {
  late int slot;
  late Type type;

  Types({required this.slot, required this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = (json['type'] != null ? new Type.fromJson(json['type']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class Type {
  late String name;

  Type({required this.name});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

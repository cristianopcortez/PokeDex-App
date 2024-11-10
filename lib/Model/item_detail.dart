class ItemDetail {
  late List<Attributes> attributes;
  late Attributes category;
  late int cost;
  late List<EffectEntries> effectEntries;
   String? flingEffect;
   int? flingPower;
  late int id;
  late String name;
  late Sprites sprites;

  ItemDetail(
      {required this.attributes,
      required this.category,
      required this.cost,
      required this.effectEntries,
        this.flingEffect,
       this.flingPower,
      required this.id,
      required this.name,
      required this.sprites});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    // print("json itemDetail : " + json.toString());
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    category = (json['category'] != null
        ? new Attributes.fromJson(json['category'])
        : null)!;
    cost = (json['cost'] != null ? json['cost'] : null);
    if (json['effect_entries'] != null) {
      effectEntries = <EffectEntries>[];
      json['effect_entries'].forEach((v) {
        effectEntries.add(new EffectEntries.fromJson(v));
      });
    }
    flingEffect = (json['fling_effect'] != null ? json['fling_effect'].toString() : "");
    flingPower = (json['fling_power'] != null ? json['fling_power'] : 0);
    id = json['id'];
    name = json['name'];
    sprites =
        (json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['cost'] = this.cost;
    if (this.effectEntries != null) {
      data['effect_entries'] =
          this.effectEntries.map((v) => v.toJson()).toList();
    }
    data['fling_effect'] = this.flingEffect;
    data['fling_power'] = this.flingPower;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }
    return data;
  }
}

class Attributes {
  late String name;
  late String url;

  Attributes({required this.name, required this.url});

  Attributes.fromJson(Map<String, dynamic> json) {
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

class EffectEntries {
  late String effect;
  late Attributes language;
  late String shortEffect;

  EffectEntries({required this.effect, required this.language, required this.shortEffect});

  EffectEntries.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
    language = (json['language'] != null
        ? new Attributes.fromJson(json['language'])
        : null)!;
    shortEffect = json['short_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effect'] = this.effect;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['short_effect'] = this.shortEffect;
    return data;
  }
}

class Sprites {
  late String url;

  Sprites({required this.url});

  Sprites.fromJson(Map<String, dynamic> json) {
    url = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['default'] = this.url;
    return data;
  }
}

class Item {
  late List<Attributes> attributes;
  late Attributes category;
  late int cost;
  late List<EffectEntries> effectEntries;
  Null flingEffect;
  late int flingPower;
  late int id;
  late String name;
  late Sprites sprites;

  Item(
      {required this.attributes,
      required this.category,
      required this.cost,
      required this.effectEntries,
      this.flingEffect,
      required this.flingPower,
      required this.id,
      required this.name,
      required this.sprites});

  Item.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    category = (json['category'] != null
        ? new Attributes.fromJson(json['category'])
        : null)!;
    cost = json['cost'];
    if (json['effect_entries'] != null) {
      effectEntries = <EffectEntries>[];
      json['effect_entries'].forEach((v) {
        effectEntries.add(new EffectEntries.fromJson(v));
      });
    }
    flingEffect = json['fling_effect'];
    flingPower = json['fling_power'];
    id = json['id'];
    name = json['name'];
    sprites =
        (json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['cost'] = this.cost;
    if (this.effectEntries != null) {
      data['effect_entries'] =
          this.effectEntries.map((v) => v.toJson()).toList();
    }
    data['fling_effect'] = this.flingEffect;
    data['fling_power'] = this.flingPower;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }
    return data;
  }
}

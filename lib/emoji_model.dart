import 'dart:convert';

List<Emoji> resultFromJson(String str) =>
    List<Emoji>.from(json.decode(str).map((x) => Emoji.fromJson(x)));

String resultToJson(List<Emoji> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emoji {
  String name;
  Category category;
  Group group;
  List<String> htmlCode;
  List<String> unicode;

  Emoji({
    required this.name,
    required this.category,
    required this.group,
    required this.htmlCode,
    required this.unicode,
  });

  factory Emoji.fromJson(Map<String, dynamic> json) => Emoji(
        name: json["name"],
        category: categoryValues.map[json["category"]]!,
        group: groupValues.map[json["group"]]!,
        htmlCode: List<String>.from(json["htmlCode"].map((x) => x)),
        unicode: List<String>.from(json["unicode"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": categoryValues.reverse[category],
        "group": groupValues.reverse[group],
        "htmlCode": List<dynamic>.from(htmlCode.map((x) => x)),
        "unicode": List<dynamic>.from(unicode.map((x) => x)),
      };
}

enum Category {
  ACTIVITIES,
  ANIMALS_AND_NATURE,
  FLAGS,
  FOOD_AND_DRINK,
  OBJECTS,
  SMILEYS_AND_PEOPLE,
  SYMBOLS,
  TRAVEL_AND_PLACES
}

final categoryValues = EnumValues({
  "activities": Category.ACTIVITIES,
  "animals and nature": Category.ANIMALS_AND_NATURE,
  "flags": Category.FLAGS,
  "food and drink": Category.FOOD_AND_DRINK,
  "objects": Category.OBJECTS,
  "smileys and people": Category.SMILEYS_AND_PEOPLE,
  "symbols": Category.SYMBOLS,
  "travel and places": Category.TRAVEL_AND_PLACES
});

enum Group {
  ACTIVITIES,
  ANIMAL_AMPHIBIAN,
  ANIMAL_BIRD,
  ANIMAL_BUG,
  ANIMAL_MAMMAL,
  ANIMAL_MARINE,
  ANIMAL_REPTILE,
  BODY,
  CAT_FACE,
  CLOTHING,
  CREATURE_FACE,
  DISHWARE,
  DRINK,
  EMOTION,
  FACE_NEGATIVE,
  FACE_NEUTRAL,
  FACE_POSITIVE,
  FACE_ROLE,
  FACE_SICK,
  FAMILY,
  FLAGS,
  FOOD_ASIAN,
  FOOD_FRUIT,
  FOOD_PREPARED,
  FOOD_SWEET,
  FOOD_VEGETABLE,
  MONKEY_FACE,
  OBJECTS,
  PERSON,
  PERSON_ACTIVITY,
  PERSON_GESTURE,
  PERSON_ROLE,
  PLANT_FLOWER,
  PLANT_OTHER,
  SKIN_TONE,
  SYMBOLS,
  TRAVEL_AND_PLACES
}

final groupValues = EnumValues({
  "activities": Group.ACTIVITIES,
  "animal amphibian": Group.ANIMAL_AMPHIBIAN,
  "animal bird": Group.ANIMAL_BIRD,
  "animal bug": Group.ANIMAL_BUG,
  "animal mammal": Group.ANIMAL_MAMMAL,
  "animal marine": Group.ANIMAL_MARINE,
  "animal reptile": Group.ANIMAL_REPTILE,
  "body": Group.BODY,
  "cat face": Group.CAT_FACE,
  "clothing": Group.CLOTHING,
  "creature face": Group.CREATURE_FACE,
  "dishware": Group.DISHWARE,
  "drink": Group.DRINK,
  "emotion": Group.EMOTION,
  "face negative": Group.FACE_NEGATIVE,
  "face neutral": Group.FACE_NEUTRAL,
  "face positive": Group.FACE_POSITIVE,
  "face role": Group.FACE_ROLE,
  "face sick": Group.FACE_SICK,
  "family": Group.FAMILY,
  "flags": Group.FLAGS,
  "food asian": Group.FOOD_ASIAN,
  "food fruit": Group.FOOD_FRUIT,
  "food prepared": Group.FOOD_PREPARED,
  "food sweet": Group.FOOD_SWEET,
  "food vegetable": Group.FOOD_VEGETABLE,
  "monkey face": Group.MONKEY_FACE,
  "objects": Group.OBJECTS,
  "person": Group.PERSON,
  "person activity": Group.PERSON_ACTIVITY,
  "person gesture": Group.PERSON_GESTURE,
  "person role": Group.PERSON_ROLE,
  "plant flower": Group.PLANT_FLOWER,
  "plant other": Group.PLANT_OTHER,
  "skin tone": Group.SKIN_TONE,
  "symbols": Group.SYMBOLS,
  "travel and places": Group.TRAVEL_AND_PLACES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

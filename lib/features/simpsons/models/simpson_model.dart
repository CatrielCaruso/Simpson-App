import 'dart:convert';

class SimpsonModel {
  String quote;
  String character;
  String image;
  String characterDirection;

  SimpsonModel({
    required this.quote,
    required this.character,
    required this.image,
    required this.characterDirection,
  });

  factory SimpsonModel.fromRawJson(String str) =>
      SimpsonModel.fromJson(json.decode(str));

  factory SimpsonModel.fromJson(Map<String, dynamic> json) => SimpsonModel(
        quote: json["quote"],
        character: json["character"],
        image: json["image"],
        characterDirection: json["characterDirection"],
      );
}

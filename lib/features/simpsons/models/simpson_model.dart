import 'dart:convert';

class SimpsonModel {
  int? index;
  String quote;
  String? quoteTranslatedIntoSpanish;
  String character;
  String image;
  String characterDirection;

  SimpsonModel(
      {required this.quote,
      required this.character,
      required this.image,
      required this.characterDirection,
      this.index});

  factory SimpsonModel.fromRawJson(String str) =>
      SimpsonModel.fromJson(json.decode(str));

  factory SimpsonModel.fromJson(Map<String, dynamic> json) => SimpsonModel(
        quote: json["quote"],
        character: json["character"],
        image: json["image"],
        characterDirection: json["characterDirection"],
      );
}

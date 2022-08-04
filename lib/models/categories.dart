// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int? mainCode;
  int? code;
  List<Datum>? data;
  dynamic error;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        mainCode: json["mainCode"],
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.image,
    this.haveStores,
    this.createdAt,
  });

  int? id;
  String? name;
  String? image;
  int? haveStores;
  DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        haveStores: json["haveStores"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "haveStores": haveStores,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}

// To parse this JSON data, do
//
//     final sliders = slidersFromJson(jsonString);

import 'dart:convert';

Sliders slidersFromJson(String str) => Sliders.fromJson(json.decode(str));

String slidersToJson(Sliders data) => json.encode(data.toJson());

class Sliders {
  Sliders({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int? mainCode;
  int? code;
  List<Datum>? data;
  dynamic error;

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
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
    this.userId,
    this.adminId,
    this.link,
    this.categoryId,
    this.image,
    this.status,
    this.typeOfAdvertisement,
    this.createdAt,
  });

  int? id;
  int? userId;
  int? adminId;
  String? link;
  dynamic categoryId;
  String? image;
  int? status;
  dynamic typeOfAdvertisement;
  DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        link: json["link"],
        categoryId: json["category_id "],
        image: json["image"],
        status: json["status"],
        typeOfAdvertisement: json["type_of_advertisement"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "admin_id": adminId,
        "link": link,
        "category_id ": categoryId,
        "image": image,
        "status": status,
        "type_of_advertisement": typeOfAdvertisement,
        "created_at":
            "${createdAt?.year.toString().padLeft(4, '0')}-${createdAt?.month.toString().padLeft(2, '0')}-${createdAt?.day.toString().padLeft(2, '0')}",
      };
}

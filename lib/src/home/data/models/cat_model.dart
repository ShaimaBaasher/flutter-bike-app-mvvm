import 'dart:convert';

class CatModelList {
  List<CatModel> requestList;

  CatModelList({
    required this.requestList,
  });

  factory CatModelList.fromJsonList(List<dynamic> jsonList) {
    List<CatModel> requests =
    jsonList.map((json) => CatModel.fromJson(json)).toList();
    return CatModelList(requestList: requests);
  }
}

class CatModel {
  int id;
  String name;
  String image;
  DateTime creationAt;
  DateTime updatedAt;

  CatModel({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CatModel.fromRawJson(String str) => CatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

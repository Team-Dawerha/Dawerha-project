class ItemCodeObject {
  String id;
  String type;

  ItemCodeObject(this.id, this.type);

  ItemCodeObject.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        type = json["type"];
}

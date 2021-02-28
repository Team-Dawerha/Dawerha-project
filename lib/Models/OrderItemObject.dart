class OrderItemObject {
  String id;
  String order_id;
  String item_id;
  String picture;
  int weight;
  int real_weight;

  OrderItemObject(
    this.id,
    this.order_id,
    this.item_id,
    this.picture,
    this.weight,
    this.real_weight,
  );

  OrderItemObject.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        order_id = json["order_id"],
        item_id = json["item_id"],
        picture = json["picture"],
        weight = json["weight"],
        real_weight = json["real_weight"];
}

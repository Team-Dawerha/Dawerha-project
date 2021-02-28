class AddressObject {
  String id;
  double lat;
  double lng;
  String user_id;

  AddressObject(
    this.id,
    this.lat,
    this.lng,
    this.user_id,
  );

  AddressObject.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        lat = json["lat"],
        lng = json["lng"],
        user_id = json["user_id"];
}

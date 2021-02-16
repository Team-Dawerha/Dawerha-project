import 'package:shared_preferences/shared_preferences.dart';

Future<List<double>> getCachedCoords() async {
  List<double> output = [];
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  double lat = sharedPreferences.getDouble('my_lat') ?? 0.0;
  double lng = sharedPreferences.getDouble('my_lng') ?? 0.0;
  output.add(lat);
  output.add(lng);
  return output;
}

Future setId(String id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('id', id);
  return id;
}

Future<String> getId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String id = sharedPreferences.getString('id') ?? "";
  return id;
}

Future setName(String name) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('name', name);
  return name;
}

Future<String> getName() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String name = sharedPreferences.getString('name') ?? "";
  return name;
}

Future setEmail(String email) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('email', email);
  return email;
}

Future<String> getEmail() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String email = sharedPreferences.getString('email') ?? "";
  return email;
}

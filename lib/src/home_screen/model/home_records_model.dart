import 'dart:convert';

List<Records> recordsFromJson(String str) =>
    List<Records>.from(json.decode(str).map((x) => Records.fromJson(x)));

String recordsToJson(List<Records> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Records {
  String id;
  String name;
  List<Location> locations;
  DateTime datecreated;
  DateTime startingtime;
  DateTime endingtime;
  double temperature;
  String weather;

  Records({
    required this.id,
    required this.name,
    required this.locations,
    required this.datecreated,
    required this.startingtime,
    required this.endingtime,
    required this.temperature,
    required this.weather,
  });

  factory Records.fromJson(Map<String, dynamic> json) => Records(
        id: json["id"],
        name: json["name"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        datecreated: DateTime.parse(json["datecreated"]),
        startingtime: DateTime.parse(json["startingtime"]),
        endingtime: DateTime.parse(json["endingtime"]),
        temperature: json["temperature"].toDouble(),
        weather: json["weather"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "datecreated": datecreated.toIso8601String(),
        "startingtime": startingtime.toIso8601String(),
        "endingtime": endingtime.toIso8601String(),
        "temperature": temperature,
        "weather": weather,
      };
}

class Location {
  double lat;
  double long;

  Location({
    required this.lat,
    required this.long,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

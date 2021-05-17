class Location {
  final int altitude;
  final int longitude;

  Location({
    this.altitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        longitude: json["longitude"],
        altitude: json["altitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "altitude": altitude,
      };
}

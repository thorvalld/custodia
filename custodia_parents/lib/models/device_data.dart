import 'location.dart';

class DeviceData {
  final bool isWifiActive;
  final bool isLocationActive;
  final bool isSoundActive;
  final int batteryLevel;
  final String belongsTo;
  final double runtime;
  final Location currentLocation;

  DeviceData(
      {this.isWifiActive,
      this.isSoundActive,
      this.isLocationActive,
      this.runtime,
      this.batteryLevel,
      this.belongsTo,
      this.currentLocation});

  factory DeviceData.fromJson(Map<String, dynamic> json) => DeviceData(
        isWifiActive: json["isWifiActive"],
        isLocationActive: json["isLocationActive"],
        isSoundActive: json["isSoundActive"],
        batteryLevel: json["batteryLevel"],
        runtime: json["runtime"],
        currentLocation: Location.fromJson(json["Location"]),
      );

  Map<String, dynamic> toJson() => {
        "isWifiActive": isWifiActive,
        "isLocationActive": isLocationActive,
        "isSoundActive": isSoundActive,
        "batteryLevel": batteryLevel,
        "runtime": runtime,
        "Location": currentLocation.toJson(),
      };
}

class Bus{
  const Bus(
      {required this.line,
      required this.code,
      required this.speed,
      required this.lat,
      required this.lon});

  final String line;
  final String code;
  final double speed;
  final double lat;
  final double lon;

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      line: json['annotations']['value'][0].split('%3A')[2],
      code: json['fleetVehicleId']['value'],
      speed: (json['speed']['value'] as num).toDouble(),
      lat: json['location']['value']['coordinates'][1],
      lon: json['location']['value']['coordinates'][0],
    );
  }
}

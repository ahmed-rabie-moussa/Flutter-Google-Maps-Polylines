import '../models/route.dart';

class Bus {
  int id;

  Route route;

  Bus({
    this.id,
    this.route,
  });

  Bus.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
  }
}

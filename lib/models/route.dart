import '../models/route_path.dart';

class Route {
  int id;
  String name;
  List<RoutePath> routePath;

  Route({
    this.id,
    this.name,
    this.routePath,
  });

  Route.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['name'];
    if (json['routePath'] != null) {
      routePath = new List<RoutePath>();
      json['routePath'].forEach((v) {
        routePath.add(new RoutePath.fromJson(v));
      });
    }
  }
}

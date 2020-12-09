class RoutePath {
  double lat;
  double lng;

  RoutePath({this.lat, this.lng});

  RoutePath.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

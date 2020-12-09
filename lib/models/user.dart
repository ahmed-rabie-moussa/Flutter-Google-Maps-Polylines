import '../models/bus.dart';

class User {
  int id;
  Bus bus;

  User({
    this.id,
    this.bus,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
  }
}

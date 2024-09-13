import 'package:uuid/uuid.dart';

var uuid = const Uuid();


class RandomId {

  static String getRandomId() {
    return uuid.v4().toString();
  }
}
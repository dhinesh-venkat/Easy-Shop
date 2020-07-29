import 'package:flutter/foundation.dart';

class Group {
  String id;
  String value;
  String imageUrl;

  Group({
    @required this.id,
    @required this.value,
    this.imageUrl,
  });
}

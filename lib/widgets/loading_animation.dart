import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

final String _animationName = 'Cargando';

Widget loadingAnimation() {
  return Container(
    child: FlareActor(
      "assets/animations/cute_bot.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: _animationName,
    ),
  );
}

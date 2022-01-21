import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
      WidgetBuilder builder, 
      RouteSettings settings
  }) : super(
    builder: builder,
    settings: settings, 
  );
}
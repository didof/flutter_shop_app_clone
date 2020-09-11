import 'package:flutter/material.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  Size size,
);

class ResponsiveSafeArea extends StatelessWidget {
  final ResponsiveBuilder responsiveBuilder;
  final bool hasPadding;

  const ResponsiveSafeArea(
      {Key key, @required builder, this.hasPadding = false})
      : responsiveBuilder = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (hasPadding) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: responsiveBuilder(context, constraints.biggest),
            );
          } else
            return responsiveBuilder(context, constraints.biggest);
        },
      ),
    );
  }
}

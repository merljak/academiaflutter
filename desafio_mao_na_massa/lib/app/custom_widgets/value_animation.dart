import 'package:flutter/material.dart';

class ValueAnimation extends ImplicitlyAnimatedWidget {
  final double value;
  ValueAnimation({
    Key key,
    this.value,
  }) : super(
            duration: Duration(seconds: 1),
            curve: Curves.elasticInOut,
            key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _ValueAnimation();
}

class _ValueAnimation extends AnimatedWidgetBaseState<ValueAnimation> {
  Tween _count;
  @override
  Widget build(BuildContext context) {
    double value = _count.evaluate(animation);
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: 'R\$',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' ${value.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _count = visitor(
      _count,
      widget.value,
      (dynamic value) => Tween(begin: value),
    );
  }
}

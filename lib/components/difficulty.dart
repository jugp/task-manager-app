import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  const Difficulty({
    super.key,
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 15,
          color: index < level ? Colors.blue : Colors.blue[100],
        );
      }),
    );
  }
}

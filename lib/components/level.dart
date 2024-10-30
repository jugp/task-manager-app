import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  const Level({
    super.key,
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                color: Colors.white,
                value: level / 10,
              ),
            ),
            Text(
              'Nível: $level',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final void Function(String?)? onSaved;

  const TextInputField({
    super.key,
    required this.label,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira o valor';
            }
            return null;
          },
          onSaved: onSaved,
        ),
      ),
    );
  }
}

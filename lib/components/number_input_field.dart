import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatelessWidget {
  final String label;
  final int min;
  final int max;
  final void Function(String?)? onSaved;

  const NumberInputField({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            final int? number = int.tryParse(value ?? '');
            if (number == null || number < min || number > max) {
              return 'Por favor, insira um número entre $min e $max';
            }
            return null;
          },
          onSaved: onSaved,
        ),
      ),
    );
  }
}

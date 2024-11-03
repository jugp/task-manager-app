import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UrlInputField extends StatefulWidget {
  final String label;
  final void Function(String?)? onSaved;

  const UrlInputField({
    super.key,
    required this.label,
    this.onSaved,
  });

  @override
  State<UrlInputField> createState() => _UrlInputFieldState();
}

class _UrlInputFieldState extends State<UrlInputField> {
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: widget.label,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma URL';
                  } else if (!Uri.tryParse(value)!.hasAbsolutePath) {
                    return 'Por favor, insira uma URL válida';
                  }
                  return null;
                },
                onSaved: widget.onSaved,
                onChanged: (value) {
                  setState(() {
                    imageUrl = value;
                  });
                }),
            if (imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 200,
                  child: Image.network(imageUrl!,
                      errorBuilder: (context, error, stackTrace) {
                    return const Text('Não foi possível carregar a imagem.');
                  }, fit: BoxFit.cover),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

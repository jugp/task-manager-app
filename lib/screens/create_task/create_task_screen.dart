import 'package:flutter/material.dart';
import 'package:task_manager/screens/create_task/widgets/number_input_field.dart';
import 'package:task_manager/screens/create_task/widgets/text_input_field.dart';
import 'package:task_manager/data/task_dao.dart';
import '../../components/task.dart';
import 'widgets/url_input_field.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _difficulty = 1;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarefas'),
        ),
        body: Container(
          color: Colors.blueAccent,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Wrap(
                runSpacing: 20,
                children: <Widget>[
                  TextInputField(
                    label: 'Nome',
                    onSaved: (value) => _name = value!,
                  ),
                  NumberInputField(
                    label: 'Dificuldade',
                    min: 1,
                    max: 5,
                    onSaved: (value) => _difficulty = int.parse(value!),
                  ),
                  UrlInputField(
                    label: 'Imagem',
                    onSaved: (value) => _imageUrl = value!,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processando Dados')),
                          );

                          //TaskInherited.of(context).newTask(_name, _imageUrl!, _difficulty);

                          TaskDao().save(Task(_name, _imageUrl!, _difficulty));

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                          'Enviar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

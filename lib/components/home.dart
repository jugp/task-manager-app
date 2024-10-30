import 'package:flutter/material.dart';
import 'package:task_manager/components/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0.3,
        duration: const Duration(milliseconds: 1000),
        child: ListView(
          children: const [
            Task(
                'Aprender Flutter',
                'assets/images/dash.png',
                3),
            Task(
                'Andar de Bike',
                'assets/images/bike.webp',
                2),
            Task(
                'Meditar',
                'assets/images/meditar.jpeg',
                5),
            Task(
                'Ler',
                'assets/images/livro.jpg',
                4),
            Task('Jogar',
                'assets/images/jogar.webp',
                1
            ),
            SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = !opacity;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}

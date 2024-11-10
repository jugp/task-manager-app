import 'package:flutter/material.dart';
import '../components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });

  final List<Task> taskList = [
    const Task('Aprender Flutter', 'assets/images/dash.png', 3),
    const Task('Andar de Bike', 'assets/images/bike.webp', 2),
    const Task('Meditar', 'assets/images/meditar.jpeg', 5),
    const Task('Ler', 'assets/images/livro.jpg', 4),
    const Task('Jogar', 'assets/images/jogar.webp', 1)
  ];

  void newTask(String name, String image, int difficulty) {
    taskList.add(Task(name, image, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}

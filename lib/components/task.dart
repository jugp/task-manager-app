import 'package:flutter/material.dart';
import 'package:task_manager/data/task_dao.dart';
import './difficulty.dart';
import 'level.dart';

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficulty;

  const Task(this.name, this.image, this.difficulty, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int level = 0;

  bool isNetworkImage() {
    return widget.image.contains('http');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                  color: Colors.amber,
                  height: 100,
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 100,
                        color: Colors.grey,
                        child: isNetworkImage()
                            ? Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.image,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 184,
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 22,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Difficulty(level: widget.difficulty)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (level < 10) {
                                  level++;
                                }
                              });
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Deletar"),
                                    content: Text("Tem certeza que deseja deletar?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Sim'),
                                        onPressed: () {
                                          TaskDao().delete(widget.name);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Tarefa deletada!')),
                                          );
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Não'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ));



                            },
                            child: const Icon(Icons.arrow_drop_up)),
                      )
                    ],
                  )),
              Level(level: level),
            ],
          ),
        ));
  }
}

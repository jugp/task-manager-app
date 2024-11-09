import 'package:flutter/material.dart';
import 'package:task_manager/data/task_dao.dart';
import 'package:task_manager/data/task_inherited.dart';
import 'package:task_manager/screens/form_screen.dart';

import '../components/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> _futureData;

  Future<List<Task>> fetchData() async {
    return await TaskDao().findAll();
  }

  void _createItem() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    ).then((_){
      setState(() {
        _futureData = fetchData();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _futureData = fetchData();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder(
            future: _futureData,
            builder: (context, snapshot) {
              print('Estado: $snapshot.connectionState');
              if (snapshot.connectionState == ConnectionState.done) {
                List<Task>? items = snapshot.data;
                if (snapshot.hasData && items != null && items.length > 0) {
                  print('Com dados');
                  print(items);
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return items[index];
                      });
                } else {
                  print('Sem dados');
                  return const Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        )
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Carregando',
                        style: TextStyle(fontSize: 32),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}

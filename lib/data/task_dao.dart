import 'package:sqflite/sqflite.dart';
import 'package:task_manager/data/database.dart';
import '../components/task.dart';

class TaskDao {
  static const String _tableName = 'task';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  static const String createTableSql = '''
    CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_name TEXT,
      $_difficulty INTEGER,
      $_image TEXT
    )
  ''';

  List<Task> toList(List<Map<String, dynamic>> list) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> item in list) {
      final Task task = Task(item[_name], item[_image], item[_difficulty]);
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> toMap(Task task) {
    return {_name: task.name, _difficulty: task.difficulty, _image: task.image};
  }

  Future<List<Task>> findAll() async {
    print('Listando todos elementos');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return toList(result);
  }

  Future<List<Task>> find(String name) async {
    print('Encontrando elemento: ${name}');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: '$_name = ?', whereArgs: [name]);
    return toList(result);
  }

  save(Task task) async {
    final Database db = await getDatabase();
    final List<Task> items = await find(task.name);

    if (items.isEmpty) {
      print('Inserindo novo elemento: ${task.name}');
      await db.insert(_tableName, toMap(task));
    } else {
      print('Atualizando elemento: ${task.name}');
      await db.update(_tableName, toMap(task),
          where: '$_name = ?', whereArgs: [task.name]);
    }
  }

  delete(String name) async {
    final Database db = await getDatabase();
    print('Deletando elemento: ${name}');
    await db.delete(_tableName, where: '$_name = ?', whereArgs: [name]);
  }
}

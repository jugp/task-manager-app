import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager/data/task_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');

  //await deleteDatabase(path);

  return openDatabase(path, onCreate: (db, version) async {
    print('Criando tabela');
    await db.execute(TaskDao.createTableSql);
  }, version: 1);
}



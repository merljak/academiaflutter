import 'package:todo_list_sqlite/database/connection.dart';
import 'package:todo_list_sqlite/models/todo_model.dart';

class TodosRepository {
  //!
  //! Method findByPeriod - find all activities between a date time period range
  //! This method need's a initial and final date
  //!
  Future<List<TodoModel>> findByPeriod(DateTime start, DateTime end) async {
    var startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    var endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    var conn = await Connection().instance;
    var result = await conn.rawQuery(
      '''
          SELECT * FROM todo 
          WHERE data_hora 
          BETWEEN ? AND ? 
          ORDER BY data_hora 
      ''',
      [startFilter.toIso8601String(), endFilter.toIso8601String()],
    );
    return result.map((t) => TodoModel.fromMap(t)).toList();
  }

// 2021-01-03T23:45:14.773716
  //!
  //! Method saveTodo - Save a new task in the database
  //! This method need's a description and a datetime
  //!
  Future<void> saveTodo(DateTime dateTimeTask, String descricao) async {
    var conn = await Connection().instance;
    await conn.rawInsert(
      ''' 
          INSERT 
          INTO todo 
          VALUES(?,?,?,?)
      ''',
      [null, descricao, dateTimeTask.toIso8601String(), 0],
    );
  }

  //!
  //! Method checkUnchekTodo - check and uncheck an task to change the task status
  //! This method need's a todo task objec to capture the task id
  //!
  Future<void> checkUnchekTodo(TodoModel todo) async {
    var conn = await Connection().instance;
    await conn.rawUpdate(
      '''
          UPDATE todo SET 
          finalizado = ? WHERE id = ?
      ''',
      [todo.finalizado ? 1 : 0, todo.id],
    );
  }

  //!
  //! Method removeTodoTask - remove task from database
  //! This method need's a todo task objec to capture the task id
  //!
  Future<void> removeTodoTaskById(int id) async {
    var conn = await Connection().instance;
    await conn.rawDelete(
      '''
      DELETE FROM todo
      WHERE id = ?
      ''',
      [id],
    );
  }
}

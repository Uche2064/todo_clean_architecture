import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/feature/todo/data/database/todo_remote_db.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoRemoteDb remoteDb;
  TodoRepoImpl({required this.remoteDb});

  @override
  Future<Either<Failure, Todo>> addTodo(Todo todo) async {
    try {
      final result = await remoteDb.addTodoFirebase(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'We could not add todo $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(Todo todo) async {
    try {
      final result = await remoteDb.deleteTodoFirebase(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'We could not delete'));
    }
    ;
  }

  @override
  Future<Either<Failure, Todo>> editTodo(Todo todo) async {
    try {
      final result = await remoteDb.editTodoFirebase(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'We could not edit todo'));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Todo>>>> getAllTodos() async {
    try {
      final result = remoteDb.getTodosFromFirebase();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'We could not get all todos'));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    try {
      final result = await remoteDb.getTodoByIdFirebase(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'We could not get todo'));
    }
  }
}

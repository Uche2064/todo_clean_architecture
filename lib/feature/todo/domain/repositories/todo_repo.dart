import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';

abstract class TodoRepo {
  Future<Either<Failure, Todo>> addTodo(Todo todo);

  Future<Either<Failure, Todo>> editTodo(Todo todo);

  Future<Either<Failure, void>> deleteTodo(Todo todo);

  Future<Either<Failure, Stream<List<Todo>>>> getAllTodos();

  Future<Either<Failure, Todo>> getTodoById(String id);
}

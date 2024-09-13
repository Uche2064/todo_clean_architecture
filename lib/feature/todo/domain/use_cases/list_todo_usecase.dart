
import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/core/usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';

class ListTodoUsecase implements Usecase<Stream<List<Todo>>, NoParams> {

  final TodoRepo repo;
  ListTodoUsecase(this.repo);

  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(NoParams params) {
    return repo.getAllTodos();
  }

}
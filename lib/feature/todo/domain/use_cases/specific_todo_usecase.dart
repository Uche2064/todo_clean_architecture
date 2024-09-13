

import 'package:dartz/dartz.dart';
import 'package:todo_app_clean_architecture/core/errors/failure.dart';
import 'package:todo_app_clean_architecture/core/usecase.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/repositories/todo_repo.dart';

class SpecificTodoUsecase implements Usecase<Todo, Params<String>> {

  final TodoRepo repo;
  SpecificTodoUsecase(this.repo);

  @override
  Future<Either<Failure, Todo>> call(Params<String> params) {
    return repo.getTodoById(params.data);
  }

}
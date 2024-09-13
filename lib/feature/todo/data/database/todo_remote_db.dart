import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';

abstract class TodoRemoteDb {
  // add todo to firebase
  Future<Todo> addTodoFirebase(Todo todo);

  // edit todo
  Future<Todo> editTodoFirebase(Todo todo);

  // delete todo
  Future<void> deleteTodoFirebase(Todo todo);

  // get all todos
  Stream<List<Todo>> getTodosFromFirebase();

  // get single todo
  Future<Todo> getTodoByIdFirebase(String id);
}

class TodoRemoteDbImpl extends TodoRemoteDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Todo> addTodoFirebase(Todo todo) async {
    await _firestore
        .collection('Todos')
        .doc(todo.id)
        .set(todo.toJson(), SetOptions(merge: true));
    return todo;
  }

  @override
  Future<void> deleteTodoFirebase(Todo todo) async {
    await _firestore.collection('Todos').doc(todo.id).delete();
  }

  @override
  Future<Todo> editTodoFirebase(Todo todo) async {
    await _firestore.collection('Todos').doc(todo.id).update(todo.toJson());
    return todo;
  }

  @override
  Future<Todo> getTodoByIdFirebase(String id) async {
    var doc = await _firestore.collection('Todos').doc(id).get();
    return Todo.fromJson(doc.data()!);
  }

  @override
  Stream<List<Todo>> getTodosFromFirebase() async* {
    yield* _firestore.collection('Todos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
    });
  }
}

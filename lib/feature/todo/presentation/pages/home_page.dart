import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todo_app_clean_architecture/feature/todo/domain/entities/todo.dart';
import 'package:todo_app_clean_architecture/feature/todo/presentation/controller/todo_controller.dart';
import 'package:todo_app_clean_architecture/feature/todo/presentation/widgets/custom_text_formfield.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Todo clean architecture',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showBottomSheetDialog(context), // Passe le context ici
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: _buildListView(),
      ),
    );
  }

  void _showBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (_) {
          controller.titleController.clear();
          controller.descriptionController.clear();
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            width: double.maxFinite,
            height: Get.height * 0.8,
            child: _buildSheetContent(context),
          );
        });
  }

  Padding _buildSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CustomTextFormfield(
                fieldName: 'title', controller: controller.titleController),
            const Gap(10),
            CustomTextFormfield(
                fieldName: 'description',
                controller: controller.descriptionController),
            const SizedBox(height: 10),
            _buildElevatedButton(context),
          ],
        ),
      ),
    );
  }

  SizedBox _buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            controller.addTodo();
            Navigator.pop(context);
          }
        },
        child: const Text(
          'Add',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  SizedBox _buildEditElevatedButton(BuildContext context, {Todo? todo}) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            
            controller.editTodo(todo!);
            Navigator.pop(context);
          }
        },
        child: const Text(
          'Edit',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return StreamBuilder(
        stream: controller.listTodo(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Center(child: Text('Error: ${snapshots.error}'));
          }
          if (snapshots.data!.isEmpty) {
            return Center(child: Text('No todo found'));
          }
          if (snapshots.hasData) {
            final todos = snapshots.data!;
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    subtitle: Text(todos[index].description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.titleController.text =
                                  todos[index].title;
                              controller.descriptionController.text =
                                  todos[index].description;
                              _showEditBottomSheet(context, todo: todos[index]);
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                          onPressed: () => controller.deleteTodo(todos[index]),
                          icon: Icon(Icons.delete_forever),
                        )
                      ],
                    ),
                  );
                });
          }
          return SizedBox.shrink();
        });
  }

  void _showEditBottomSheet(BuildContext context, {Todo? todo}) {
    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            width: double.maxFinite,
            height: Get.height * 0.8,
            child: _buildEditSheetContent(context, todo: todo),
          );
        });
  }

  Padding _buildEditSheetContent(BuildContext context, {Todo? todo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CustomTextFormfield(
              fieldName: controller.titleController.text,
              controller: controller.titleController,
            ),
            const Gap(10),
            CustomTextFormfield(
              fieldName: controller.descriptionController.text,
              controller: controller.descriptionController,
            ),
            const SizedBox(height: 10),
            _buildEditElevatedButton(context, todo: todo),
          ],
        ),
      ),
    );
  }
}

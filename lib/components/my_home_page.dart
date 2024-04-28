import 'package:flutter/material.dart';
import 'package:flutter_todo_app/util/dialog_box.dart';
import 'package:flutter_todo_app/util/my_text.dart';
import 'package:flutter_todo_app/util/todo_tile.dart';

List todoLists = [
  {
    'taskName': 'Go into the gym',
    'taskCompleted': false,
  },
  {
    'taskName': 'Complete the project',
    'taskCompleted': false,
  },
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  // text controller
  final _textController = TextEditingController();

  var todoListLength = todoLists.length;

  void displayTodoLength() {
    setState(() {
      todoListLength = todoLists.length;
    });
  }

  // save new todo
  void saveNewTodo() {
    if (_textController.text.isNotEmpty) {
      // todoLists.add([
      //   _textController.text,
      //   false,
      // ]);
      setState(() {
        todoLists.add({
          'taskName': _textController.text,
          'taskCompleted': false,
        });
      });
      displayTodoLength();
      Navigator.of(context).pop();
    }
  }

  // update existing todo
  void updateTodo(int todoIndex) {
    if (_textController.text.isNotEmpty) {
      // todoLists[todoIndex] = _textController.text;
      setState(() {
        todoLists[todoIndex] = {
          'taskName': _textController.text,
          'taskCompleted': todoLists[todoIndex]['taskCompleted'],
        };
      });
      displayTodoLength();
      Navigator.of(context).pop();
    }
  }

  // create a new todo
  void createNewTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _textController,
          onSave: saveNewTodo,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Update a todo
  void updateTodoDialog(int index) {
    _textController.text = todoLists[index]['taskName'] as String;
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _textController,
          onSave: () => updateTodo(index),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete the a todo
  void deleteTodo(int index) {
    setState(() {
      todoLists.removeAt(index);
    });
    displayTodoLength();
  }

  void toggleCheckbox(bool? value, int index) {
    setState(() {
      todoLists[index]['taskCompleted'] = value;
      // todoLists[index]['taskCompleted'] = !todoLists[index]['taskCompleted'];
    });
  }

  int completedTaskCounter() {
    var completedTasks = 0;
    for (var i = 0; i < todoLists.length; i++) {
      if (todoLists[i]['taskCompleted'] == true) {
        completedTasks++;
      }
    }
    return completedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[300],
          title: const MyText(text: 'Flutter Todo App'),
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTodo,
          backgroundColor: Colors.teal[300],
          child: const Icon(Icons.add),
        ),
        body: Container(
          color: Colors.teal[100],
          // Add a header to the page
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: 'My Tasks',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    MyText(
                      text: todoListLength <= 0
                          ? 'No task yet'
                          : (todoListLength == completedTaskCounter() &&
                                  todoListLength > 0)
                              ? 'All tasks completed'
                              : '$todoListLength ${todoListLength > 1 ? 'tasks' : 'task'} : ${completedTaskCounter()} Done',
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              // List of todos
              Expanded(
                child: ListView.builder(
                  itemCount: todoLists.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      taskName: todoLists[index]['taskName'] as String,
                      taskCompleted: todoLists[index]['taskCompleted'] as bool,
                      onChanged: (bool? value) => toggleCheckbox(value, index),
                      deleteFunction: (BuildContext context) =>
                          deleteTodo(index),
                      updateFunction: (BuildContext context) =>
                          updateTodoDialog(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

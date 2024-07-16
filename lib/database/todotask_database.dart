import 'package:hive/hive.dart';

class TodotaskDatabase {
  final mybox = Hive.box("mybox");
  List task = [];

  void createInitialData() {
    task = [];
    mybox.put('TODOLIST', task);
  }

  void loadData() {
    task = List<List<dynamic>>.from(mybox.get('TODOLIST', defaultValue: []));
  }

  void updateData() {
    mybox.put("TODOLIST", task);
  }
}

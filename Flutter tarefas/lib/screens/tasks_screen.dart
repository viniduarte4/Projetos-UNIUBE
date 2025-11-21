import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../services/storage_service.dart';

class TasksScreen extends StatefulWidget {
  final DateTime? date;
  TasksScreen({this.date});
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late DateTime _date;
  final _taskCtrl = TextEditingController();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _date = widget.date ?? DateTime.now();
    _load();
  }

  String get _key => DateFormat('dd-MM-yyyy').format(_date);

  void _load() async {
    _tasks = await StorageService.loadTasksForDate(_key);
    setState((){});
  }

  void _add() async {
    final text = _taskCtrl.text.trim();
    if (text.isEmpty) return;
    final t = Task(id: DateTime.now().millisecondsSinceEpoch.toString(), title: text, done: false);
    _tasks.add(t);
    await StorageService.saveTasksForDate(_key, _tasks);
    _taskCtrl.clear();
    setState((){});
  }

  void _toggle(Task t) async {
    t.done = !t.done;
    await StorageService.saveTasksForDate(_key, _tasks);
    setState((){});
  }

  void _remove(Task t) async {
    _tasks.removeWhere((e) => e.id == t.id);
    await StorageService.saveTasksForDate(_key, _tasks);
    setState((){});
  }

  @override
Widget build(BuildContext context) {

  final List<Task> pendentes = _tasks.where((t) => !t.done).toList();
  final List<Task> concluidas = _tasks.where((t) => t.done).toList();


  final List<Task> ordenadas = [...pendentes, ...concluidas];

  return Scaffold(
    appBar: AppBar(title: Text('Tarefas - ' + _key)),
    body: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskCtrl,
                  decoration: InputDecoration(hintText: 'Nova tarefa'),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(onPressed: _add, child: Text('+')),
            ],
          ),
          SizedBox(height: 12),
          Expanded(
            child: ordenadas.isEmpty
                ? Center(child: Text('Nenhuma tarefa'))
                : ListView.builder(
                    itemCount: ordenadas.length,
                    itemBuilder: (_, i) {
                      final t = ordenadas[i];
                      return ListTile(
                        leading: Checkbox(
                            value: t.done,
                            onChanged: (_) => _toggle(t)
                        ),
                        title: Text(
                          t.title,
                          style: TextStyle(
                            decoration:
                                t.done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _remove(t),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ),
  );
}
}
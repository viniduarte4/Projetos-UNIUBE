import 'package:flutter/material.dart';
import 'tasks_screen.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selected = DateTime.now();
  final _dateFmt = DateFormat('dd-MM-yyyy');

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selected = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendário')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Data selecionada'),
                subtitle: Text(_dateFmt.format(_selected)),
                trailing: ElevatedButton(onPressed: _pickDate, child: Text('Selecionar dia')),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TasksScreen(date: _selected)));
              },
              child: Text('Abrir tarefas desse dia'),
            )
          ],
        ),
      ),
    );
  }
}

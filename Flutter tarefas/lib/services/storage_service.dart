import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static SharedPreferences? _prefs;
  static const _usersKey = 'ft_users';
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Simple local "auth" (for demo only)
  static void register(String email, String pass) {
    final map = _prefs!.getString(_usersKey);
    Map<String, dynamic> users = map == null ? {} : jsonDecode(map);
    users[email] = pass;
    _prefs!.setString(_usersKey, jsonEncode(users));
  }

  static bool login(String email, String pass) {
    final map = _prefs!.getString(_usersKey);
    if (map == null) return false;
    final users = jsonDecode(map) as Map<String,dynamic>;
    if (users.containsKey(email) && users[email] == pass) {
      return true;
    }
    return false;
  }

  // Tasks storage per date key (yyyy-MM-dd)
  static Future<List<Task>> loadTasksForDate(String key) async {
    final raw = _prefs!.getString('tasks_' + key);
    if (raw == null) return [];
    final arr = jsonDecode(raw) as List<dynamic>;
    return arr.map((e) => Task.fromJson(e as Map<String,dynamic>)).toList();
  }

  static Future saveTasksForDate(String key, List<Task> tasks) async {
    final raw = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await _prefs!.setString('tasks_' + key, raw);
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

class AppProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool get hasUser => _user != null;

  AppProvider() {
    _loadUser();
  }

  void _loadUser() {
    final box = Hive.box<UserModel>('users');
    if (box.isNotEmpty) {
      _user = box.getAt(0);
    }
    notifyListeners();
  }

  Future<void> createUser({
    required String name,
    required int age,
    required String country,
    required String category,
    required String parentName,
  }) async {
    final box = Hive.box<UserModel>('users');
    final user = UserModel(
      name: name,
      age: age,
      country: country,
      category: category,
      parentName: parentName,
      streak: 1,
    );
    final today = DateTime.now().toLocal().toString().split(' ')[0];
    user.attendance[today] = 'present';
    await box.clear();
    await box.add(user);
    _user = user;
    notifyListeners();
  }

  Future<void> markPresent() async {
    if (_user == null) return;
    final today = DateTime.now().toLocal().toString().split(' ')[0];
    _user!.attendance[today] = 'present';
    _updateStreak();
    await _user!.save();
    notifyListeners();
  }

  Future<void> markTired() async {
    if (_user == null) return;
    final today = DateTime.now().toLocal().toString().split(' ')[0];
    _user!.attendance[today] = 'tired';
    await _user!.save();
    notifyListeners();
  }

  Future<void> completeVideo(String subject) async {
    if (_user == null) return;
    _user!.videosWatched++;
    await markPresent();
    notifyListeners();
  }

  Future<void> completeTopic(String subject, int topicIndex) async {
    if (_user == null) return;
    final current = _user!.topicProgress[subject] ?? 0;
    if (topicIndex >= current) {
      _user!.topicProgress[subject] = topicIndex + 1;
      final stampKey = '${subject}_$topicIndex';
      if (!_user!.stamps.contains(stampKey)) {
        _user!.stamps.add(stampKey);
      }
    }
    await _user!.save();
    notifyListeners();
  }

  void _updateStreak() {
    if (_user == null) return;
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final yday = yesterday.toLocal().toString().split(' ')[0];
    if (_user!.attendance[yday] == 'present') {
      _user!.streak++;
    } else {
      final todayKey = today.toLocal().toString().split(' ')[0];
      if (_user!.attendance[todayKey] != 'present') {
        _user!.streak = 1;
      }
    }
  }

  bool get wasAbsentYesterday {
    if (_user == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yday = yesterday.toLocal().toString().split(' ')[0];
    return _user!.attendance[yday] == 'absent';
  }

  double getSubjectProgress(String subject, int totalTopics) {
    if (_user == null || totalTopics == 0) return 0;
    final done = _user!.topicProgress[subject] ?? 0;
    return done / totalTopics;
  }

  double get attendanceRate {
    if (_user == null || _user!.attendance.isEmpty) return 0;
    final present = _user!.attendance.values.where((v) => v == 'present').length;
    return present / _user!.attendance.length;
  }
}

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String country;

  @HiveField(3)
  String category;

  @HiveField(4)
  String parentName;

  @HiveField(5)
  int streak;

  @HiveField(6)
  int videosWatched;

  @HiveField(7)
  List<String> stamps;

  @HiveField(8)
  Map<String, int> topicProgress;

  @HiveField(9)
  Map<String, String> attendance;

  @HiveField(10)
  DateTime createdAt;

  UserModel({
    required this.name,
    required this.age,
    required this.country,
    required this.category,
    required this.parentName,
    this.streak = 0,
    this.videosWatched = 0,
    List<String>? stamps,
    Map<String, int>? topicProgress,
    Map<String, String>? attendance,
    DateTime? createdAt,
  })  : stamps = stamps ?? [],
        topicProgress = topicProgress ?? {},
        attendance = attendance ?? {},
        createdAt = createdAt ?? DateTime.now();

  String get level {
    if (age <= 8) return 'Level 1';
    if (age <= 10) return 'Level 2';
    if (age <= 12) return 'Level 3';
    if (age <= 14) return 'Level 4';
    if (age <= 16) return 'Level 5';
    return 'Level 6';
  }

  String get flagEmoji {
    const flags = {
      'United Kingdom': '🇬🇧',
      'India': '🇮🇳',
      'Japan': '🇯🇵',
      'USA': '🇺🇸',
      'Pakistan': '🇵🇰',
      'Nigeria': '🇳🇬',
      'Bangladesh': '🇧🇩',
      'Germany': '🇩🇪',
      'Canada': '🇨🇦',
      'Australia': '🇦🇺',
    };
    return flags[country] ?? '🌍';
  }
}

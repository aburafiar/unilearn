// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[0] as String,
      age: fields[1] as int,
      country: fields[2] as String,
      category: fields[3] as String,
      parentName: fields[4] as String,
      streak: fields[5] as int,
      videosWatched: fields[6] as int,
      stamps: (fields[7] as List).cast<String>(),
      topicProgress: (fields[8] as Map).cast<String, int>(),
      attendance: (fields[9] as Map).cast<String, String>(),
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.parentName)
      ..writeByte(5)
      ..write(obj.streak)
      ..writeByte(6)
      ..write(obj.videosWatched)
      ..writeByte(7)
      ..write(obj.stamps)
      ..writeByte(8)
      ..write(obj.topicProgress)
      ..writeByte(9)
      ..write(obj.attendance)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

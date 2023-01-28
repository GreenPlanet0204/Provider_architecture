// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHAdapter extends TypeAdapter<PostH> {
  @override
  final int typeId = 1;

  @override
  PostH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostH(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      userId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PostH obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

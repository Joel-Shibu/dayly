// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_modes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppModeAdapter extends TypeAdapter<AppMode> {
  @override
  final int typeId = 10;

  @override
  AppMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppMode.student;
      case 1:
        return AppMode.work;
      case 2:
        return AppMode.exam;
      case 3:
        return AppMode.personal;
      default:
        return AppMode.student;
    }
  }

  @override
  void write(BinaryWriter writer, AppMode obj) {
    switch (obj) {
      case AppMode.student:
        writer.writeByte(0);
        break;
      case AppMode.work:
        writer.writeByte(1);
        break;
      case AppMode.exam:
        writer.writeByte(2);
        break;
      case AppMode.personal:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

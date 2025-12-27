// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DaySummaryAdapter extends TypeAdapter<DaySummary> {
  @override
  final int typeId = 3;

  @override
  DaySummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DaySummary(
      date: fields[0] as DateTime,
      totalTasks: fields[1] as int,
      focusTasks: fields[2] as int,
      completedTasks: fields[3] as int,
      skippedTasks: fields[4] as int,
      status: fields[5] as DayStatus,
    );
  }

  @override
  void write(BinaryWriter writer, DaySummary obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.totalTasks)
      ..writeByte(2)
      ..write(obj.focusTasks)
      ..writeByte(3)
      ..write(obj.completedTasks)
      ..writeByte(4)
      ..write(obj.skippedTasks)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DaySummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DayStatusAdapter extends TypeAdapter<DayStatus> {
  @override
  final int typeId = 2;

  @override
  DayStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DayStatus.complete;
      case 1:
        return DayStatus.partial;
      case 2:
        return DayStatus.skipped;
      default:
        return DayStatus.complete;
    }
  }

  @override
  void write(BinaryWriter writer, DayStatus obj) {
    switch (obj) {
      case DayStatus.complete:
        writer.writeByte(0);
        break;
      case DayStatus.partial:
        writer.writeByte(1);
        break;
      case DayStatus.skipped:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

import 'package:flutter/material.dart' show Color, TimeOfDay;
import 'package:hive/hive.dart' show TypeAdapter, BinaryReader, BinaryWriter;

class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) => Color(reader.readInt());

  @override
  void write(BinaryWriter writer, Color obj) => writer.writeInt(obj.value);

  @override
  int get typeId => 200;
}

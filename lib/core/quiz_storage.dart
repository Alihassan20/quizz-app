import 'package:get_storage/get_storage.dart';

abstract class AppStorage {
  static const String _BOX = 'Notes';
  static GetStorage _box = GetStorage();
  static Future<void> init() async =>
      await GetStorage.init();

 static List getNotes() => _box.hasData(_BOX) ? _box.read(_BOX) : [];

  static Future<void> addNote(String value) async {
    final Text = getNotes();
    Text.insert(0, value);
    await _box.write(_BOX, Text);


  }
}
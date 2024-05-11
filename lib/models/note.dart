import 'package:isar/isar.dart';
// this line is needed to generate file
// then we need to run the below command : dart run build_runner build
part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}

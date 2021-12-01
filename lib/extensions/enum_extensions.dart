import 'string_extensions.dart';

extension EnumValueToString on Enum {
  String enumToString() {
    final enumValue = toString().split('.')[1];
    return enumValue.capitalize();
  }
}

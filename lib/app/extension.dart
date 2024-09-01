import 'package:tut_app/app/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return AppConstants.emptyString;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return AppConstants.emptyInteger;
    } else {
      return this!;
    }
  }
}

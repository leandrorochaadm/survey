import 'package:meta/meta.dart';

abstract class Validation {
  ValidationError validade({@required String field, @required String value});
}

enum ValidationError {
  requiredField,
  invalidField,
}

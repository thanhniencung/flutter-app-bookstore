import 'package:flutter_app_book_store/shared/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testing phone', () {
    final phone1 = "0973987489";
    final result1 = Validation.isPhoneValid(phone1);
    expect(result1, true);

    final phone2 = "0973987489fdsfsdf";
    final result2 = Validation.isPhoneValid(phone2);
    expect(result2, false);

    final phone3 = "fshdjkfhsdjkfh";
    final result3 = Validation.isPhoneValid(phone3);
    expect(result3, false);
  });
}

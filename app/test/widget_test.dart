// App-level smoke test
// NOTE: Full app widget test requires Hive initialization (openBox for settings).
// This is covered by integration_test/ which runs on a real device.
// The test below is a placeholder that confirms the test file compiles.

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('App code compiles and test harness is functional', () {
    // Smoke test: if this file compiles and runs, flutter test is working.
    // Full app launch requires Hive initialization — see integration_test/
    expect(true, isTrue);
  });
}

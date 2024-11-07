import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
// make sure wrap unconstraint widgets with expanded widget.
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // ).then(
  //   (fn) {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Expenses(),
        ),
      );
  //   },
  // );
}

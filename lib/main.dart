import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp( GOTApp(appRouter: AppRouter(),));
}

class GOTApp extends StatelessWidget {
  final AppRouter appRouter;

  const GOTApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

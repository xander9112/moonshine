import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/translation_service.dart';
import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TranslationService _translationService = TranslationService();
  await _translationService.init('ru');

  runApp(MoonshineApp());
}

class MoonshineApp extends StatelessWidget {
  final TranslationService _translationService = TranslationService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: _translationService.supportedLocales(),
      title: _translationService.text('appTitle'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

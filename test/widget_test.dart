import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aplikasi_goksfood/main.dart';

void main() {
  testWidgets('shows splash screen on startup', (WidgetTester tester) async {
    await tester.pumpWidget(const GoksFoodApp());

    expect(find.text('GOKS FOOD'), findsOneWidget);
    expect(find.text('Culinary Modern & Cita Rasa Kita'), findsOneWidget);
    expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
  });
}

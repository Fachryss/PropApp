import 'package:flutter/material.dart';
import '../screen/splash_screen.dart';
import '../screen/intro_page.dart';
import '../screen/critical/critical_1.dart';
import '../screen/critical/critical_2.dart';
import '../screen/critical/critical_3.dart';
import '../screen/question_checkbox.dart';
import '../screen/interactive_page.dart';
import '../screen/multiple_choice_page.dart';

import '../screen/closing_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // '/': (_) => const SplashScreen(),
  '/intro': (_) => const IntroPage(),
  '/critical1': (_) => const Critical1Page(),
  '/critical2': (_) => const Critical2Page(),
  '/critical3': (_) => const Critical3Page(),
  '/checkbox': (_) => const QuestionCheckboxPage(),
  '/interactive': (_) => const InteractivePage(),
  '/multiple': (_) => const MultipleChoicePage(),
  '/closing': (_) => const ClosingPage(),
};

import 'package:flutter/material.dart';
import 'package:propapp/screen/dice_experiment_1.dart';
import 'package:propapp/screen/dice_experiment_2.dart';
import 'package:propapp/screen/dice_experiment_3.dart';
import 'package:propapp/screen/dice_summary.dart';
import 'package:propapp/screen/dice_table_1.dart';
import 'package:propapp/screen/question_checkbox_2.dart';
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

  // '/intro': (_) => const IntroPage(),
  // '/critical1': (_) => const Critical1Page(),
  // '/critical2': (_) => const Critical2Page(),
  // '/critical3': (_) => const Critical3Page(),
  // '/checkbox': (_) => const QuestionCheckboxPage(),
  // '/checkbox2': (_) => const QuestionCheckboxPage2(),
  '/interactive': (_) => const ProbabilitySelectionPage(),
  '/dice': (_) => const DiceExperimentPage1(),
  '/dice3': (_) => const DiceExperimentPage3(),
  // '/diceTable1': (_) => const DiceResultsTablePage1(),
  '/diceSummary': (_) => const ExperimentSummaryPage(),
  '/multiple': (_) => const MultipleChoicePage(),
  '/closing': (_) => const ClosingPage(),
};

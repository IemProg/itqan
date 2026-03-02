import 'package:flutter/material.dart';
import 'package:itqan/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

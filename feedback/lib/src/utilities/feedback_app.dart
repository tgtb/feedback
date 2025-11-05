// ignore_for_file: public_member_api_docs

import 'package:feedback/src/l18n/localization.dart';
import 'package:feedback/src/theme/feedback_theme.dart';
import 'package:feedback/src/utilities/media_query_from_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FeedbackApp extends StatefulWidget {
  const FeedbackApp({
    super.key,
    required this.child,
    this.themeMode,
    this.theme,
    this.darkTheme,
    this.localizationsDelegates,
    this.localeOverride,
  });

  final Widget child;
  final ThemeMode? themeMode;
  final FeedbackThemeData? theme;
  final FeedbackThemeData? darkTheme;
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? localeOverride;

  @override
  State<FeedbackApp> createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp> {
  @override
  void initState() {
    super.initState();

    final dispatcher = SchedulerBinding.instance.platformDispatcher;
    dispatcher.onPlatformBrightnessChanged = () {
      setState(() => {});
    };
  }

  FeedbackThemeData _buildThemeData(BuildContext context) {
    final ThemeMode mode = widget.themeMode ?? ThemeMode.system;
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    final bool useDarkMode = mode == ThemeMode.dark ||
        (mode == ThemeMode.system && brightness == Brightness.dark);
    FeedbackThemeData? themeData;

    if (useDarkMode && widget.darkTheme != null) {
      themeData = widget.darkTheme;
    } else if (useDarkMode && widget.theme == null) {
      themeData = FeedbackThemeData.dark();
    }

    themeData ??= widget.theme ?? FeedbackThemeData.light();

    return themeData;
  }

  @override
  Widget build(BuildContext context) {
    final themeWrapper = FeedbackTheme(
      data: _buildThemeData(context),
      child: widget.child,
    );

    Widget mediaQueryWrapper;

    /// Don't replace existing MediaQuery widget if it exists.
    if (MediaQuery.maybeOf(context) == null) {
      mediaQueryWrapper = MediaQueryFromWindow(child: themeWrapper);
    } else {
      mediaQueryWrapper = themeWrapper;
    }

    return FeedbackLocalization(
      delegates: widget.localizationsDelegates,
      localeOverride: widget.localeOverride,
      child: mediaQueryWrapper,
    );
  }
}

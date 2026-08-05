/// Available modes of the feedback ui.
enum FeedbackMode {
  /// The user is able to draw on your application.
  /// While in drawing mode, the user is not able to navigate within the app.
  draw,

  /// The user is able to navigate within your application.
  /// While in navigation mode, the user is not able to draw.
  navigate,

  /// The user is able to view application.
  /// While in view mode, the user is not able to draw or navigate, and the right bar doesn't display.
  view,
}

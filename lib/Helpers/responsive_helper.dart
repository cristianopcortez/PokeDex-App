class ResponsiveHelper {
  double width;
  double height;
  double fontSize;
  double titleFontSize;

  static ResponsiveHelper? _instance;

  factory ResponsiveHelper({
    required double width,
    required double height,
    required double fontSize,
    required double titleFontSize,
  }) {
    _instance ??= ResponsiveHelper._internal(
      width,
      height,
      fontSize,
      titleFontSize,
    );
    return _instance!;
  }

  ResponsiveHelper._internal(
    this.width,
    this.height,
    this.fontSize,
    this.titleFontSize,
  );

  static ResponsiveHelper get instance {
    if (_instance == null) {
      throw Exception('Instance not initialized');
    }
    return _instance!;
  }
}

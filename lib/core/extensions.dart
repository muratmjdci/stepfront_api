
import '../../routes.dart';

/// Makes the values responsive according to the device
///
/// you can give the same values according to the design, sizes will be show the same in all devices
///
/// 30.w; or 30.h;
extension Responsive on num {
  // values based on current design
  double get w => this * Routes.context.size!.width / 375;
  double get h => this * Routes.context.size!.height / 812;
}

/// Shortcuts for Durations
///
/// [FROM] Future.Delayed(const Duration(milliseconds:300));
///
/// [TO] Future.Delayed(300.ms);
extension DurationExtension on int {
  Duration get s => Duration(seconds: this);
  Duration get ms => Duration(milliseconds: this);
}

import 'package:richtext_editor/universal_ui/universal_ui.dart';

class PlatformViewRegistry {
  static void registerViewFactory(String viewId, dynamic cb) {
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}

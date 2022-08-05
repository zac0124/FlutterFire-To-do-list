import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';

final _tKey = GlobalKey(debugLabel: 'overlay_parent');

late OverlayEntry _loadingEntry;

bool isDarkTheme = false;
bool _loaderShown = false;

class Loading extends StatelessWidget {
  final Widget? child;
  final bool darkTheme;

  const Loading({Key? key, this.child, this.darkTheme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;

  void visitor(Element element) {
    if (navigator != null) return;
    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  context.visitChildElements(visitor);
  assert(navigator != null, '''unable to show overlay''');
  return navigator!.overlay;
}

Future<void> showLoadingIndicator(
    {bool isModal = true, Color? modalColor}) async {
  try {
    debugPrint('Showing loading overlay');
    final _child = Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        width: 30,
        height: 30,
      ),
    );
    await _showOverlay(
      child: isModal
          ? Stack(
              children: [
                ModalBarrier(
                  color: modalColor,
                ),
                _child
              ],
            )
          : _child,
    );
  } catch (err) {
    debugPrint('Exception showing loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> hideLoadingIndicator() async {
  try {
    debugPrint('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    debugPrint('Exception hiding loading overlay');
    throw err;
  }
}

Future<void> _showOverlay({required Widget child}) async {
  try {
    final overlay = _overlayState;

    if (_loaderShown) {
      debugPrint('An overlay is already showing');
      return Future.value(false);
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay?.insert(overlayEntry);
    _loadingEntry = overlayEntry;
    _loaderShown = true;
  } catch (err) {
    debugPrint('Exception inserting loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> _hideOverlay() async {
  try {
    _loadingEntry.remove();
    _loaderShown = false;
  } catch (err) {
    debugPrint('Exception removing loading overlay\n${err.toString()}');
    throw err;
  }
}

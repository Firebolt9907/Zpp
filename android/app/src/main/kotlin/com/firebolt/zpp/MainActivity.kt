package com.firebolt.zpp

import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
// Somewhere in your app, before your FlutterFragment is needed,
// like in the Application class ...
// Instantiate a FlutterEngine.
FlutterEngine flutterEngine = new FlutterEngine(context);

// Start executing Dart code in the FlutterEngine.
flutterEngine.getDartExecutor().executeDartEntrypoint(
DartEntrypoint.createDefault()
);

// Cache the pre-warmed FlutterEngine to be used later by FlutterFragment.
FlutterEngineCache
.getInstance()
.put("engine", flutterEngine);

FlutterFragment.withCachedEngine("engine").build();


class MainActivity: FlutterActivity() {
    override fun onPostResume() {
    super.onPostResume()
    WindowCompat.setDecorFitsSystemWindows(window, false)
    window.navigationBarColor = 0
    window.statusBarColor = 1
}
}
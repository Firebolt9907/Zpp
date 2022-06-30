package com.firebolt.zpp

import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onPostResume() {
    super.onPostResume()
    WindowCompat.setDecorFitsSystemWindows(window, false)
    window.navigationBarColor = 0
    window.statusBarColor = 1
}
}
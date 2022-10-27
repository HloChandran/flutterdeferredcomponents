package com.deferred.components

import com.google.android.play.core.splitcompat.SplitCompatApplication

class CoreApp : SplitCompatApplication() {
    override fun onCreate() {
        super.onCreate()
        Flutter.getFlutterUtils().initializeFlutterEngine(applicationContext)
    }
}
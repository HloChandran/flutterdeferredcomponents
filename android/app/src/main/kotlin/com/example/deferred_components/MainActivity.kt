package com.deferred.components

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup

class MainActivity : FlutterActivity() {

    // overriding of this function is done because once I put the app in background and then comes back to the app
    // again then the deferred component show loading. This is not the case of removing app from background tray i.e https://github.com/flutter/flutter/issues/97149
    override fun onStart() {
        Flutter.getFlutterUtils().deferredComponentManager?.installDeferredComponent(
            2,
            "newdeferred"
        )
        Flutter.getFlutterUtils().deferredComponentManager?.loadDartLibrary(2, "newdeferred")
        Flutter.getFlutterUtils().deferredComponentManager?.installDeferredComponent(
            3,
            "datadeferred"
        )
        Flutter.getFlutterUtils().deferredComponentManager?.loadDartLibrary(3, "datadeferred")


        super.onStart()
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {


        return FlutterEngineCache.getInstance().get(AppConstants.FLUTTER_MAIN_ENGINE_ID_NEW_DEFERRED);

    }




}

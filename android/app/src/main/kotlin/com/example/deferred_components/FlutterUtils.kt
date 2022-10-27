package com.deferred.components

import android.content.Context
import androidx.annotation.Keep
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager

const val TAG = "FlutterUtils"

@Keep
class FlutterUtils {
    lateinit var flutterEngine: FlutterEngine
    var deferredComponentManager: PlayStoreDeferredComponentManager? = null
    fun initializeFlutterEngine(applicationContext: Context) {
        getNewDeferred(applicationContext);
       // getDataDeferred(applicationContext);

    }

//    private fun getDataDeferred(applicationContext: Context) {
//
//        if (deferredComponentManager == null) {
//            deferredComponentManager = PlayStoreDeferredComponentManager(applicationContext, null)
//
//            FlutterInjector.setInstance(
//                FlutterInjector.Builder().setDeferredComponentManager(deferredComponentManager)
//                    .build()
//            )
//            // Instantiate a FlutterEngine.
//            flutterEngine = FlutterEngine(applicationContext)
//
//            // Start executing Dart code to pre-warm the FlutterEngine.
//            flutterEngine.dartExecutor.executeDartEntrypoint(
//                DartExecutor.DartEntrypoint.createDefault()
//            )
//
//            deferredComponentManager!!.installDeferredComponent(3, "datadeferred")
//            deferredComponentManager!!.loadDartLibrary(3, "datadeferred")
//
//            // Cache the FlutterEngine to be used by FlutterActivity.
//            FlutterEngineCache.getInstance()
//                .put(AppConstants.FLUTTER_MAIN_ENGINE_ID_NEW_DEFERRED, flutterEngine)
//        }
//    }

    private fun getNewDeferred(applicationContext: Context) {

        if (deferredComponentManager == null) {
            deferredComponentManager = PlayStoreDeferredComponentManager(applicationContext, null)

            FlutterInjector.setInstance(
                FlutterInjector.Builder().setDeferredComponentManager(deferredComponentManager)
                    .build()
            )
            // Instantiate a FlutterEngine.
            flutterEngine = FlutterEngine(applicationContext)

            // Start executing Dart code to pre-warm the FlutterEngine.
            flutterEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )

            deferredComponentManager!!.installDeferredComponent(2, "newdeferred")
            deferredComponentManager!!.loadDartLibrary(2, "newdeferred")
            deferredComponentManager!!.installDeferredComponent(3, "datadeferred")
            deferredComponentManager!!.loadDartLibrary(3, "datadeferred")

            // Cache the FlutterEngine to be used by FlutterActivity.
            FlutterEngineCache.getInstance()
                .put(AppConstants.FLUTTER_MAIN_ENGINE_ID_NEW_DEFERRED, flutterEngine)
        }
    }


}




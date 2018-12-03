package ru.luharitrip.luharitrip

import android.os.Bundle

import io.flutter.app.FlutterActivity
import android.support.customtabs.CustomTabsIntent
import android.net.Uri
import android.content.Intent
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity(): FlutterActivity() {

  private val CHANNEL = "ru.luharitrip.luharitrip/nativeInteraction"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    val builder = CustomTabsIntent.Builder()
    val customTabsIntent = builder.build()

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      when (call.method) {
        "openWebView" -> customTabsIntent.launchUrl(this, Uri.parse(call.arguments.toString()))
        "shareTrip" -> shareUrl((call.arguments as ArrayList<*>)[0].toString(), (call.arguments as ArrayList<*>)[1].toString())
      }
    }

    GeneratedPluginRegistrant.registerWith(this)
  }

  private fun shareUrl(title: String, url: String) {
    val share = Intent(android.content.Intent.ACTION_SEND)
    share.type = "text/plain"
    share.putExtra(Intent.EXTRA_SUBJECT, title)
    share.putExtra(Intent.EXTRA_TEXT, url)

    startActivity(Intent.createChooser(share, "Выберите приложение"))
  }

//  override fun onCreate(savedInstanceState: Bundle?) {
//    super.onCreate(savedInstanceState)
//    GeneratedPluginRegistrant.registerWith(this)
//  }
}

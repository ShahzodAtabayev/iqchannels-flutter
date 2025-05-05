package com.example.iqchannels

import android.app.Activity
import android.content.Context
import com.example.iqchannels.activity.ChatActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import ru.iqchannels.sdk.app.IQChannels
import ru.iqchannels.sdk.app.IQChannelsConfig

class IqchannelsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private var activity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "iqchannels")
        channel.setMethodCallHandler(this)
        applicationContext = binding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "configure" -> {
                val address = call.argument<String>("address")
                val channelName = call.argument<String>("channel")
                if (address != null && channelName != null) {
                    IQChannels.configure(applicationContext, IQChannelsConfig(address, channelName))
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENTS", "address and channel are required", null)
                }
            }

            "setPushToken" -> {
                val token = call.argument<String>("token")
                val isHuawei = call.argument<Boolean>("isHuawei") ?: false
                if (token != null) {
                    IQChannels.setPushToken(token, isHuawei)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENTS", "token is required", null)
                }
            }

            "login" -> {
                val token = call.argument<String>("token")
                if (token != null) {
                    IQChannels.login(token)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENTS", "token is required", null)
                }
            }

            "logout" -> {
                IQChannels.logout()
                result.success(null)
            }

            "loginAnonymous" -> {
                IQChannels.loginAnonymous()
                result.success(null)
            }

            "logoutAnonymous" -> {
                IQChannels.logoutAnonymous()
                result.success(null)
            }

            "openChat" -> {
                val styleJson = call.argument<String>("styleJson")
                openChat(styleJson = styleJson)
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun openChat(styleJson: String?) {
        activity?.let { act ->
            val intent = android.content.Intent(act, ChatActivity::class.java)
            intent.putExtra("styleJson", styleJson)
            act.startActivity(intent)
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

package com.example.iqchannels.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import org.json.JSONObject
import ru.iqchannels.sdk.ui.ChatFragment

class ChatActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val styleJson = intent.getStringExtra("style_json")
        val container = android.widget.FrameLayout(this).apply { id = android.R.id.content }
        setContentView(container)
        val fragment = ChatFragment.newInstance(stylesJson = styleJson)
        supportFragmentManager.beginTransaction().replace(android.R.id.content, fragment).commit()
    }
}
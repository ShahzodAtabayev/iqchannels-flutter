package com.example.iqchannels.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import ru.iqchannels.sdk.ui.ChatFragment

class ChatActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val container = android.widget.FrameLayout(this).apply { id = android.R.id.content }
        setContentView(container)

        val fragment = ChatFragment.newInstance()
        supportFragmentManager.beginTransaction().replace(android.R.id.content, fragment).commit()
    }
}
package com.example.iqchannels.activity

import android.graphics.Color
import android.os.Bundle
import android.view.MenuItem
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.view.ViewCompat
import ru.iqchannels.sdk.ui.ChatFragment

class ChatActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_TITLE = "extra_title"
        const val STYLE_JSON = "style_json"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val mainLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT
            )
            fitsSystemWindows = true
        }

        val toolbar = Toolbar(this).apply {
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                dpToPx(56)
            )
            setBackgroundColor(Color.WHITE)
            setTitleTextColor(Color.BLACK)
            fitsSystemWindows = true
        }

        // Toolbar’ni Activity ga ActionBar sifatida o‘rnatamiz
        setSupportActionBar(toolbar)

        // Title’ni Intentdan olib, ActionBar orqali o‘rnatamiz
        val titleFromIntent = intent.getStringExtra(EXTRA_TITLE) ?: "Чат c оператором"
        supportActionBar?.title = titleFromIntent

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)

        val fragmentContainer = FrameLayout(this).apply {
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                0,
                1f
            )
            fitsSystemWindows = true
            id = ViewCompat.generateViewId()
        }

        mainLayout.addView(toolbar)
        mainLayout.addView(fragmentContainer)
        setContentView(mainLayout)

        val styleJson = intent.getStringExtra(STYLE_JSON)
        val fragment = ChatFragment.newInstance(stylesJson = styleJson)
        supportFragmentManager.beginTransaction()
            .replace(fragmentContainer.id, fragment)
            .commit()
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            android.R.id.home -> {
                finish()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    private fun dpToPx(dp: Int): Int {
        val density = resources.displayMetrics.density
        return (dp * density).toInt()
    }
}

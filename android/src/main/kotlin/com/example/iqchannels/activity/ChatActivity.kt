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
import android.content.res.Configuration
import org.json.JSONObject
import android.view.View
import android.widget.TextView
import android.graphics.Typeface

class ChatActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_TITLE = "extra_title"
        const val STYLE_JSON = "style_json"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val styleJson = intent.getStringExtra(STYLE_JSON)

        var chatBackgroundColor: Int = Color.WHITE
        var themeMode: String = "light" // default
        var titleTextColor = Color.BLACK
        var titleTextSizeSp = 18f
        var isBold = false
        var isItalic = false
        var textAlign = "start"


        // 🔽 1. JSON ichidan "theme" va background color'ni aniqlash
        if (!styleJson.isNullOrEmpty()) {
            try {
                val root = JSONObject(styleJson)

                // 🌓 1. theme = "light" / "dark"
//                themeMode = root.optString("theme", "light").lowercase()

                // 🟦 title_label
                val titleLabel = root.optJSONObject("chat")?.optJSONObject("title_label")

                // 🟦 color
                titleLabel?.optJSONObject("color")?.optString(themeMode)?.let {
                    titleTextColor = Color.parseColor(it)
                }

                // 🟦 text_size
                titleTextSizeSp = titleLabel?.optDouble("text_size", 18.0)?.toFloat() ?: 18f

                // 🟦 text_style
                val textStyle = titleLabel?.optJSONObject("text_style")
                isBold = textStyle?.optBoolean("bold", false) ?: false
                isItalic = textStyle?.optBoolean("italic", false) ?: false

                // 🟦 text_align
                textAlign = titleLabel?.optString("text_align", "start") ?: "start"

                // 🎨 2. background color
                val background = root.optJSONObject("chat")
                    ?.optJSONObject("background")
                val bgColorHex = background?.optString(themeMode) ?: "#FFFFFF"
                chatBackgroundColor = Color.parseColor(bgColorHex)

            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        // 🔨 Layout
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
            setBackgroundColor(chatBackgroundColor)
            setTitleTextColor(Color.BLACK)
            fitsSystemWindows = false
            // Back button rang
            navigationIcon?.setTint(titleTextColor)
        }

        setSupportActionBar(toolbar)

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
            fitsSystemWindows = false
            id = ViewCompat.generateViewId()
        }

        mainLayout.addView(toolbar)
        mainLayout.addView(fragmentContainer)
        setContentView(mainLayout)

        // 🟡 Status bar background
        window.statusBarColor = chatBackgroundColor

        // 🟡 Icon rangini o‘zgartirish — faqat agar `theme = light` bo‘lsa qora ikonka
        window.decorView.systemUiVisibility =
            if (themeMode == "light") View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR else 0

        applyTitleStyle(toolbar, titleTextColor, titleTextSizeSp, isBold, isItalic, textAlign)


        val fragment = ChatFragment.newInstance()
        supportFragmentManager.beginTransaction()
            .replace(fragmentContainer.id, fragment)
            .commit()
    }

    fun applyTitleStyle(toolbar: Toolbar, color: Int, sizeSp: Float, isBold: Boolean, isItalic: Boolean, align: String) {
        for (i in 0 until toolbar.childCount) {
            val view = toolbar.getChildAt(i)
            if (view is TextView && view.text == toolbar.title) {
                view.setTextColor(color)
                view.textSize = sizeSp

                val style = when {
                    isBold && isItalic -> Typeface.BOLD_ITALIC
                    isBold -> Typeface.BOLD
                    isItalic -> Typeface.ITALIC
                    else -> Typeface.NORMAL
                }
                view.setTypeface(null, style)

                view.textAlignment = when (align.lowercase()) {
                    "center" -> View.TEXT_ALIGNMENT_CENTER
                    "end", "right" -> View.TEXT_ALIGNMENT_VIEW_END
                    else -> View.TEXT_ALIGNMENT_VIEW_START
                }
            }
        }
    }


    fun isLightColor(color: Int): Boolean {
        val darkness =
            1 - (0.299 * Color.red(color) + 0.587 * Color.green(color) + 0.114 * Color.blue(color)) / 255
        return darkness < 0.5 // true = light, false = dark
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

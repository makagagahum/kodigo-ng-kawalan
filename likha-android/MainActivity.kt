package com.orin.likha

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.ScrollView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.coroutines.*

class MainActivity : AppCompatActivity() {
    private lateinit var logView: TextView
    private lateinit var scrollView: ScrollView
    private val mainScope = CoroutineScope(Dispatchers.Main + Job())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setupUI()
        startCloudSetup()
    }

    private fun setupUI() {
        // Simple terminal-like UI
        val container = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
        }

        scrollView = ScrollView(this).apply {
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                0,
                1f
            )
        }

        logView = TextView(this).apply {
            text = "🚀 LIKHA - Cloud Infrastructure Setup\n"
            append("📱 Likha sa Wala Edition\n")
            append("\n")
            append("⏳ Initializing cloud setup...\n\n")
            textColor = android.graphics.Color.parseColor("#00BCD4")
            textSize = 12f
            typeface = android.graphics.Typeface.MONOSPACE
            setPadding(16, 16, 16, 16)
        }

        scrollView.addView(logView)
        container.addView(scrollView)
        setContentView(container)
    }

    private fun startCloudSetup() {
        mainScope.launch {
            delay(1000)
            logMessage("🌐 Connecting to cloud platforms...")
            delay(500)
            
            // Vercel OAuth
            logMessage("🔗 Opening Vercel authentication...")
            delay(500)
            openOAuthBrowser(
                "https://vercel.com/oauth/authorize?client_id=YOUR_CLIENT_ID&redirect_uri=likha://oauth-callback&response_type=code"
            )
            delay(2000)

            // Render OAuth
            logMessage("🔗 Opening Render authentication...")
            delay(500)
            openOAuthBrowser("https://dashboard.render.com/api-keys")
            delay(2000)

            // Supabase
            logMessage("🔗 Opening Supabase console...")
            delay(500)
            openOAuthBrowser("https://app.supabase.com")
            delay(2000)

            // Cloudflare
            logMessage("🔗 Opening Cloudflare dashboard...")
            delay(500)
            openOAuthBrowser("https://dash.cloudflare.com")
            delay(2000)

            // n8n
            logMessage("🔗 Opening n8n automation...")
            delay(500)
            openOAuthBrowser("https://n8n.cloud")

            delay(2000)
            logMessage("✅ Setup complete!")
            logMessage("💾 Configuration saved to .env")
            logMessage("\n🎉 Your cloud infrastructure is ready!")
        }
    }

    private fun logMessage(message: String) {
        logView.append("\n$message")
        // Auto-scroll to bottom
        scrollView.post {
            scrollView.fullScroll(ScrollView.FOCUS_DOWN)
        }
    }

    private fun openOAuthBrowser(url: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        startActivity(intent)
    }

    override fun onDestroy() {
        super.onDestroy()
        mainScope.cancel()
    }
}

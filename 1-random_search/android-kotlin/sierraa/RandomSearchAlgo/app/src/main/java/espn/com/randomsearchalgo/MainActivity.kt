package espn.com.randomsearchalgo

import android.os.AsyncTask
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.widget.TextView
import okhttp3.OkHttpClient
import okhttp3.Request
import java.util.*

class MainActivity : AppCompatActivity() {
    val client = OkHttpClient()
    var cheapText:TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        cheapText = findViewById(R.id.cheap_text) as? TextView
        DownloadArticleTask().execute()
    }


    inner class ArticleInfo {
        var cost:Long = -1
        var url:String? = null
    }

    inner class DownloadArticleTask : AsyncTask<String, Integer, ArticleInfo>() {
        override fun doInBackground(vararg p0: String?): ArticleInfo {
            return getCheapestArticleInformation()
        }

        override fun onPostExecute(articleInfo: ArticleInfo?) {
            Handler(Looper.getMainLooper()).post {
                cheapText?.text = "${articleInfo?.url} is the cheapest with a cost of ${articleInfo?.cost}"
            }
            super.onPostExecute(articleInfo)

        }

        fun getCost(url:String) : Long {
            val response = client.newCall(Request.Builder().url(url).build()).execute()
            return response.body().string().length.toLong()
        }


        fun getCheapestArticleInformation() : ArticleInfo {
            val articles = getURLList()
            var cheapestArticleCost:Long = Long.MAX_VALUE
            var cheapestArticleUrl:String? = null
            for (i in 1..4) {
                val url = articles[Random().nextInt(articles.size)]
                try {
                    val cost = getCost(url)
                    if (cost < cheapestArticleCost) {
                        cheapestArticleCost = cost
                        cheapestArticleUrl = url
                    }
                } catch (e :Exception) {
                    Log.e("DownloadTask", e.message)
                }
            }
            val articleInfo = ArticleInfo()
            articleInfo.cost = cheapestArticleCost
            articleInfo.url = cheapestArticleUrl
            return articleInfo
        }

        fun getURLList() : List<String> {
            val list = ArrayList<String>()
            list.add("https://www.raywenderlich.com/141980/rxandroid-tutorial")
            list.add("https://medium.com/@lukleDev/how-effective-java-may-have-influenced-the-design-of-kotlin-part-1-45fd64c2f974#.v2814kc4a")
            list.add("https://medium.com/@develodroid/flutter-ii-material-design-f437e3e8e6a9#.136ut1lx5")
            list.add("https://www.androidthings.rocks/2017/01/08/your-first-blinking-led/")
            list.add("https://barmij.ly/Academy/Articles/Read/Android-Studio-Shortcuts")
            list.add("http://hannesdorfmann.com/android/mosby3-mvi-1")
            list.add("http://amysimmons.github.io/a-guide-to-the-care-and-feeding-of-new-devs/")
            list.add("https://medium.com/@MAFI8919/testing-sqlite-on-android-bfa0733e11e7#.95qu4773r")
            list.add("https://www.smashingmagazine.com/2017/01/bringing-app-data-every-user-wrist-android-wear/")
            list.add("https://android-developers.googleblog.com/2016/09/android-wear-2-0-developer-preview-3-play-store-and-more.html")
            list.add("http://tools.android.com/download/studio/builds/2-3-beta-2")
            list.add("https://developer.android.com/studio/releases/sdk-tools.html")
            return list
        }
    }
}

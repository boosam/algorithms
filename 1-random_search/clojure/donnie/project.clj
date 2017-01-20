(defproject selenium-grid "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.7.0"]
                 [compojure "1.3.4"]
                 [ring/ring-defaults "0.1.2"]
                 [org.clojure/data.json "0.2.5"]
                 [me.raynes/conch "0.8.0"]]
  :plugins [[lein-ring "0.8.13"]]
  :ring {:handler selenium-grid.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        ;[clj-time "0.11.0"]
                        [ring-mock "0.1.5"]
                        ]}})
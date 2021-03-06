webpack = require 'webpack'
webpackDevMiddleware = require 'webpack-dev-middleware'

module.exports = (app) ->
  # First we fire up webpack and pass in the configuration we created
  bundleStart = null
  compiler = webpack
    context: __dirname + '/../public'
    entry: ['./js/ryba.cjsx']
    # entry: ['webpack/hot/dev-server', './js/test.js'],
    output:
      # publicPath: 'http://localhost:8080/'
      path: __dirname + '/../public/build'
      publicPath: '/' # required for woff2 link resolution
      filename: 'bundle.js'
    plugins: [
      # new webpack.HotModuleReplacementPlugin()
      new webpack.ProvidePlugin
        $: "jquery"
        jQuery: "jquery"
        "windows.jQuery": "jquery"
    ],
    module:
      loaders: [
        # { test: /\.js$/, loader: 'imports?$=jquery!./js/ryba.js'},
        { test: /\.styl$/, loader: 'style-loader!css-loader!stylus-loader' },
        { test: /\.css$/, loader: 'style-loader!css-loader' },
        { test: /\.coffee$/, loader: 'coffee-loader' },
        { test: /\.cjsx$/, loader: 'coffee-jsx-loader' },
        { test: /\.jsx$/, loader: 'jsx-loader' },
        { test: /\.less$/, loader: 'style-loader!css-loader!less-loader' },
        { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192' },
        { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=10000&minetype=application/font-woff" },
        { test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=10000&minetype=application/font-woff2" },
        { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=10000&minetype=application/octet-stream" },
        { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file-loader" },
        { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=10000&minetype=image/svg+xml" }
      ]

  # We give notice in the terminal on bundling steps
  compiler.plugin 'compile', () ->
    console.log 'Bundling...'
    bundleStart = Date.now()

  compiler.plugin 'done', () ->
    console.log 'Bundled in ' + (Date.now() - bundleStart) + 'ms!'

  app.use webpackDevMiddleware compiler,
    devtool: 'eval'
    hot: true
    progress: true
    stats:
      colors: true
    'content-base': 'build'

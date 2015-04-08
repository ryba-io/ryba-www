
webpack = require('webpack');

module.exports = {
  context: __dirname + "/public",
  entry: ['webpack/hot/dev-server', './js/ryba.cjsx'],
  // entry: ['webpack/hot/dev-server', './js/test.js'],
  output: {
    publicPath: 'http://localhost:8080/',
    path: __dirname + './build',
    filename: 'bundle.js'
  },
  plugins: [
    // new webpack.HotModuleReplacementPlugin()
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      "windows.jQuery": "jquery"
    })
  ],
  module: {
    loaders: [
      // { test: /\.js$/, loader: 'imports?$=jquery!./js/ryba.js'},
      { test: /\.styl$/, loader: 'style-loader!css-loader!stylus-loader' },
      { test: /\.css$/, loader: 'style-loader!css-loader' },
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.cjsx$/, loader: 'coffee-jsx-loader' },
      { test: /\.jsx$/, loader: 'jsx-loader' },
      { test: /\.less$/, loader: 'style-loader!css-loader!less-loader' },
      {test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'},
      {test: /\.woff(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&minetype=application/font-woff"},
      {test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&minetype=application/font-woff2"},
      {test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&minetype=application/octet-stream"},
      {test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file"},
      {test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&minetype=image/svg+xml"},
    ]
  }
};

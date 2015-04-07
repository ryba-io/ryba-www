
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
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.cjsx$/, loader: 'coffee-jsx-loader' },
      { test: /\.jsx$/, loader: 'jsx-loader' },
      { test: /\.less$/, loader: 'less-loader' }
    ]
  }
};

const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const postcss = require('./webpack/postcss');
const loaders = require('./webpack/loaders');

module.exports = {
  output: {
    path: path.resolve(__dirname, 'elm-dist/'),
    filename: '[hash].js',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm'],
  },

  entry: [
    // 'webpack-dev-server/client?http://localhost:8080',
    path.join(__dirname, 'elm/index.js'),
  ],

  devServer: {
    inline: true,
    progress: true,
  },

  module: {
    noParse: /\.elm$/,
    loaders: [
      {
        test: /\.elm$/,
        loaders: [ 'elm-hot', 'elm-webpack?verbose=true&warn=true' ],
        exclude: [ /elm-stuff/, /node_modules/ ],
      },
      {
        test: /\.js$/,
        loaders: [ 'babel' ],
        exclude: /node_modules/,
      },
      loaders.css,
    ],
  },

  postcss: postcss,

  plugins: [
    new webpack.DefinePlugin({
      __DEV__: process.env.NODE_ENV !== 'production',
      __TEST__: JSON.stringify(process.env.TEST),
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    }),
    new HtmlWebpackPlugin({
      template: './elm/index.html',
      inject: 'body',
    }),
    new webpack.NoErrorsPlugin(),
    new CopyWebpackPlugin([
      { from: 'src/assets', to: 'assets' },
    ]),
  ],
};

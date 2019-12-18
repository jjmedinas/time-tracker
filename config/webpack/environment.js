const { environment } = require('@rails/webpacker')

module.exports = environment

const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
    Rails: ['@rails/ujs']
  })
)

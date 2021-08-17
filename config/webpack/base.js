const { webpackConfig, merge } = require('@rails/webpacker')
const webpack = require("webpack");

const jQuery = {
    resolve: {
        alias: {
            $: 'jquery/src/jquery',
            jQuery: 'jquery/src/jquery',
            jquery: 'jquery',
        }
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery'
        })
    ],
    // Eliminate CORS issue
    devServer: {
        host: 'localhost',
        port: 3000
    }
}

module.exports = merge(webpackConfig, jQuery)

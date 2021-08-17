const { webpackConfig, rules, merge } = require('@rails/webpacker')
const webpack = require("webpack");

const datatables = {
    test: /datatables\.net.*/,
    loader: "imports-loader",
    options: {
        // Disables AMD plugin as DataTables.net
        // checks for AMD before CommonJS.
        additionalCode: "var define = false;",
    },
}

rules.push(datatables);

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

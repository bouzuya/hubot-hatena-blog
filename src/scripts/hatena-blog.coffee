# Description
#   A Hubot script that display the hatena blog recent entries
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HATENA_BLOG_USERNAME
#   HUBOT_HATENA_BLOG_ID
#   HUBOT_HATENA_BLOG_API_KEY
#
# Commands:
#   hubot hatena-blog - display the hatena blog recent entries
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  blog = require 'hatena-blog-api'

  robot.respond /hatena-blog$/i, (res) ->
    client = blog
      type: 'wsse'
      username: process.env.HUBOT_HATENA_BLOG_USERNAME
      blogId: process.env.HUBOT_HATENA_BLOG_ID
      apiKey: process.env.HUBOT_HATENA_BLOG_API_KEY
    client
      .index()
      .then (r) ->
        res.send r.feed.entry.map((entry) ->
          "#{entry.link[1].$.href} #{entry.title._}"
        ).join '\n'

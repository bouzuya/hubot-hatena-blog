module.exports = function(robot) {
  var blog;
  blog = require('hatena-blog-api');
  return robot.respond(/hatena-blog$/i, function(res) {
    var client;
    client = blog({
      type: 'wsse',
      username: process.env.HUBOT_HATENA_BLOG_USERNAME,
      blogId: process.env.HUBOT_HATENA_BLOG_ID,
      apiKey: process.env.HUBOT_HATENA_BLOG_API_KEY
    });
    return client.index().then(function(r) {
      return res.send(r.feed.entry.map(function(entry) {
        return "" + entry.link[1].$.href + " " + entry.title._;
      }).join('\n'));
    });
  });
};

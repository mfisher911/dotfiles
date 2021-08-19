/**
 * Save as ~/.finicky.js
 */
module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      match: finicky.matchHostnames([
        "gmail.com",
        "google.com",
        "mixcloud.com",
        "youtube.com",
      ]),
      browser: "Google Chrome",
    },
    {
      match: finicky.matchHostnames(["mailchimp.com"]),
      browser: "Mozilla Firefox",
    },
    //     {
    //       match: finicky.matchHostnames(["medium.com"]),
    //       browser: { name: "Google Chrome", private: true },
    //     },
  ],
};
// For more examples, see the Finicky github page:
// <https://github.com/johnste/finicky>

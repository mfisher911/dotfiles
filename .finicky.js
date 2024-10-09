/**
 * Save as ~/.finicky.js
 */
module.exports = {
  defaultBrowser: "Safari",
  //   options: {
  //     logRequests: true
  //   },
  handlers: [
    {
      match: [/gmail.com/, /google.com/, /mixcloud.com/, /youtube.com/],
      browser: "Google Chrome"
    },
    {
      match: /mailchimp.com/,
      browser: "Mozilla Firefox"
    },
    //     {
    //       match: finicky.matchHostnames(["medium.com"]),
    //       browser: { name: "Google Chrome", private: true },
    //     },
  ],
    {
      match: [
        /^https:\/\/.*.csod\.com\/.*$/,
        /^https:\/\/.*\.box\.com\/.*$/,
        /^https:\/\/.*\.epic\.com\/.*$/,
        /^https:\/\/.*\.office\.net\/.*$/,
        /^https:\/\/.*\.mc.rochester.edu\/.*$/,
        /^https:\/\/.*\.urmc-sh.rochester.edu\/.*$/,
        /^https:\/\/.*\.onenote\.com\/.*$/,
        /^https:\/\/.*\.yammer\.com\/.*$/,
        /^https:\/\/mypam.rochester.edu\/.*$/,
        /^https:\/\/mypath.rochester.edu\/.*$/,
        /^https:\/\/uofr(-my)?\.sharepoint\.com\/.*$/,
        /^https?:\/\/urmc.*\.service-now\.com\/.*$/,
        /^https:\/\/nam12\.safelinks\.protection\.outlook\.com\/.*$/
      ],
      browser: "com.microsoft.edgemac"
    },
    {
      match: ({ opener }) =>
        ["Microsoft Outlook", "Microsoft Teams", "zoom.us"].includes(
          opener.name
        ),
      browser: "com.microsoft.edgemac"
    },
    {
      match: /zoom\.us\/j/,
      browser: "us.zoom.xos"
    },

    {
      match: /^http:\/\/ercd-sp.*$/,
      url: ({ url }) => {
        return {
          ...url,
          protocol: "https",
          host: url.host + ".urmc-sh.rochester.edu",
          pathname: url.pathname
        };
      },
      browser: "com.microsoft.edgemac"
    }
  ]
  //   rewrite: [
  //     // debug tool
  //     {
  //       match(all) {
  //         finicky.log(JSON.stringify(all, null, 2));
  //         return false;
  //       },
  //       url: ({ url }) => url
  //     }
  //   ]

  //   rewrite: [
  //     {
  //       match: () => true, // Execute rewrite on all incoming urls to make this example easier to understand
  //       url: ({ url }) => {
  //         const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
  //         const removeKeys = ["fbclid", "gclid"]; // Remove all query parameters matching these keys

  //         const search = url.search
  //           .split("&")
  //           .map((parameter) => parameter.split("="))
  //           .filter(
  //             ([key]) =>
  //               !removeKeysStartingWith.some((startingWith) =>
  //                 key.startsWith(startingWith)
  //               )
  //           )
  //           .filter(
  //             ([key]) => !removeKeys.some((removeKey) => key === removeKey)
  //           );

  //         return {
  //           ...url,
  //           search: search.map((parameter) => parameter.join("=")).join("&")
  //         };
  //       }
  //     },
  //     {
  //       match: ({ url }) =>
  //         url.host.includes("zoom.us") && url.pathname.includes("/j/"),
  //       url({ url }) {
  //         try {
  //           var pass = "&pwd=" + url.search.match(/pwd=(\w*)/)[1];
  //         } catch {
  //           var pass = "";
  //         }
  //         var conf = "confno=" + url.pathname.match(/\/j\/(\d+)/)[1];
  //         return {
  //           search: conf + pass,
  //           pathname: "/join",
  //           protocol: "zoommtg"
  //         };
  //       }
  //     }
  //   ]
};
// For more examples, see the Finicky github page:
// <https://github.com/johnste/finicky>

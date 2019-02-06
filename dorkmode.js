// Add this to bottom of /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
// This works as of 1-17-2019, Slack version 3.3.6
// Not likely to work if/when Slack updates things.

// Add any personal customizations you might come up with:
additionalCustomizations = `
  .c-message--light .c-message__sender .c-message__sender_link {
    color: #d6d6d6;
  }
  .c-message__body {
    color: #c5c8c6;
  }

  #footer_archives_preview {
    background-color: #424242;
    border-top: 1px solid #191919;
  }

  .c-archive_footer__title {
    color: #a5a6a9;
  }

  .c-archive_footer__metadata {
    color: #98999a;
  }
`

// Context: https://github.com/laCour/slack-night-mode/issues/73#issuecomment-287467332
document.addEventListener('DOMContentLoaded', function() {
  $.ajax({
    url: 'https://raw.githubusercontent.com/laCour/slack-night-mode/master/css/raw/black.css',
    success: function(css) {
      $("<style></style>").appendTo('head').html(css + additionalCustomizations);
    }
  });
});

// Oh hello there, here's some more hot tips!
// 1. make your sidebar fit in a bit more:
//    - add this as the Sidebar theme in preferences:
//      #272b2e,#2C3849,#6698c8,#FFFFFF,#313e4d,#c5c8c6,#94E864,#264d35
//
// 2. Add these terminal aliases to make the tamper/update process smoother should you so desire:
// // copy contents of this file, open Slack file so you can paste at bottom:
// alias dorkmode='cat path/to/this/dorkmode.js | pbcopy; vi /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'
//
// // open slack with dev menu available (alt-cmd-i), great for experimenting with own styles & dorking around
// alias slack='SLACK_DEVELOPER_MENU=true open -a /Applications/Slack.app'

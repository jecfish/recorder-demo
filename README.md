# Introduction

Demostrate how to customize the replay of JSON user flow (Generate with [Chrome DevTools Recorder](https://goo.gle/devtools-recorder)) using [Puppeteer Replay](https://goo.gle/puppeteer-replay).

# Setup

1. Download the project.
1. Install dependecies: `npm install`.
1. Install puppeteer if you don't have one `npm install puppeteer`.

# Run the examples

The `src/screenshot-ext.js` will take screenshot after every step. All JSON user flows are in the `/recordings` folder.

- Use `npm start` to run the command programmatically.
- Use `npm run replay` to run multiple recordings with Puppeteer Replay CLI.
- You can also import the JSON file into [Chrome DevTools Recorder](https://goo.gle/devtools-recorder).
- See `.github/workflows/node.js.yml` to see how to setup the user flows to run on everyday 12:30pm / commits.

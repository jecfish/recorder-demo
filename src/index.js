import url from "url";
import { createRunner } from "@puppeteer/replay";
import puppeteer from "puppeteer";
import { readFileSync } from "fs";
import ScreenshootExtension from "./screenshot-ext.js";

// Launch browser
const browser = await puppeteer.launch();
const page = await browser.newPage();

// Read a JSON user flow
const json = readFileSync('./recordings/order-a-coffee.json', 'utf-8');
const flow = JSON.parse(json);


// Setup a runner
async function run(extension) {
  const runner = await createRunner(flow, extension);
  await runner.run();
}

// Replay the user flow with extension
await run(new ScreenshootExtension(browser, page));

// Close browser
await browser.close();

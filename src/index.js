import { createRunner } from "@puppeteer/replay";
import puppeteer from "puppeteer";
import { readFileSync, readdirSync } from "fs";
import ScreenshootExtension from "./screenshot-ext.js";

// Get folder
const folder = "./recordings";
const recordings = readdirSync(folder);

// Launch browser
const browser = await puppeteer.launch();
const page = await browser.newPage();

// Loop recordings
for (const rec of recordings) {
  // Get user flow
  const file = `${folder}/${rec}`;
  const json = readFileSync(file, "utf-8");
  const flow = JSON.parse(json);

  // Replay user flow with extension
  const runner = await createRunner(flow, new ScreenshootExtension(browser, page));
  await runner.run();
}

// Close browser
await browser.close();

import { readdirSync, readFileSync } from "fs";
import puppeteer from "puppeteer";
import { createRunner } from "@puppeteer/replay";
import ScreenshootExtension from "./screenshot-cloud-ext.js";

// Get folder and task index
const folder = "./recordings";
const recordings = readdirSync(folder);
const n = process.env.CLOUD_RUN_JOB ? +process.env.CLOUD_RUN_TASK_INDEX : 0;

// Launch browser
const browser = await puppeteer.launch();
const page = await browser.newPage();

// Get and replay user flows with extension
const file = `${folder}/${recordings[n]}`;
const json = readFileSync(file, "utf-8");
const flow = JSON.parse(json);

// Replay user flow with extension
const runner = await createRunner(flow, new ScreenshootExtension(browser, page));
const result = await runner.run();

// Close browser
await browser.close();

// Verify result
if (result) {
  console.log(
    `User flow ${n} completed successfully: ${recordings[n]}.`
  );
  process.exit();
} else {
  console.log(
    `User flow ${n} completed with errors: ${recordings[n]}.`
  );
  process.exit(1);
}

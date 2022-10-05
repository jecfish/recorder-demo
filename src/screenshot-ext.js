import { mkdirSync } from "fs";
import { PuppeteerRunnerExtension } from "@puppeteer/replay";

let screenshotFolder = "_screenshots";

if (process.env.CLOUD_RUN_JOB) {
  screenshotFolder = "/tmp";
} else {
  mkdirSync(screenshotFolder, { recursive: true });
}

/**
 * An extension to take screenshot after each step
 * For full extension interface, See https://goo.gle/puppeteer-replay
 */
export default class ScreenshootExtension extends PuppeteerRunnerExtension {
  count = 0;

  async afterEachStep(step, flow) {
    await super.afterEachStep(step, flow);
    this.count = this.count + 1;

    const path = `${screenshotFolder}/${flow.title}-${this.count}.png`;
    await this.page.screenshot({ path });

    console.log(`Save screenshot as ${path}`);
  }

  async afterAllSteps(step, flow) {
    await super.afterAllSteps(step, flow);
  
    const logTemplate = process.env.CLOUD_RUN_JOB ? "%s" : "\x1B[42;97m%s\x1B[m";
    console.log(logTemplate, "Operation completes successfully.");
  }
}

import { mkdirSync } from "fs";
import { PuppeteerRunnerExtension } from "@puppeteer/replay";

mkdirSync('_screenshots', {recursive: true});
let count = 0;

/**
 * An extension to take screenshot after each step
 */
 export default class ScreenshootExtension extends PuppeteerRunnerExtension {

  async afterEachStep(step, flow) {
    await super.afterEachStep(step, flow);
    count = count + 1;
    console.log(`Save screenshot for step ${count}.`);
    await this.page.screenshot({ path: `_screenshots/step-${count}.png` });
  }

  async afterAllSteps(step, flow) {
    await super.afterAllSteps(step, flow);
    console.log(`\x1B[42;97m%s\x1B[m`, "Operation completes successfully.");
  }
}
import { mkdirSync } from "fs";
import { PuppeteerRunnerExtension } from "@puppeteer/replay";

mkdirSync('_screenshots', {recursive: true});

/**
 * An extension to take screenshot after each step
 * For full extension interface, See https://goo.gle/puppeteer-replay
 */
 export default class ScreenshootExtension extends PuppeteerRunnerExtension {

  count = 0;

  async afterEachStep(step, flow) {
    await super.afterEachStep(step, flow);
    this.count = this.count + 1;
    const path = `_screenshots/${flow.title}-${this.count}.png`;
    await this.page.screenshot({path});
    console.log(`Save screenshot as ${path}`);
  }

  async afterAllSteps(step, flow) {
    await super.afterAllSteps(step, flow);
    console.log(`\x1B[42;97m%s\x1B[m`, "Operation completes successfully.");
  }
}

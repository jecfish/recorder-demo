import { PuppeteerRunnerExtension } from "@puppeteer/replay";
import { Storage } from "@google-cloud/storage";

// Create a bucket to store sreenshots
const bucketName = process.env.BUCKET_NAME;
const storageRegion = process.env.STORAGE_REGION;
const storage = new Storage();
const bucket = await createStorageBucketIfMissing(storage, bucketName);

/**
 * An extension to take screenshot after each step and save it to cloud
 * For full extension interface, See https://goo.gle/puppeteer-replay
 */
export default class ScreenshootExtension extends PuppeteerRunnerExtension {
  count = 0;

  async afterEachStep(step, flow) {
    await super.afterEachStep(step, flow);

    this.count = this.count + 1;
    const fileName = `${flow.title}-${this.count}.png`;

    const imageBuffer = await this.page.screenshot();
    await bucket.file(fileName).save(imageBuffer);

    console.log(`Save screenshot as ${fileName}`);
  }

  async afterAllSteps(step, flow) {
    await super.afterAllSteps(step, flow);
  
    const logTemplate = process.env.CLOUD_RUN_JOB ? "%s" : "\x1B[42;97m%s\x1B[m";
    console.log(logTemplate, "Operation completes successfully.");
  }
}

async function createStorageBucketIfMissing(storage, bucketName) {
  const bucket = storage.bucket(bucketName);
  const [exists] = await bucket.exists();

  if (exists) return bucket;

  const [createdBucket] = await storage.createBucket(bucketName, {
    location: storageRegion,
  });

  return createdBucket;
}

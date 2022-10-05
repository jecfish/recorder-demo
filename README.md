# Introduction

Demostrate how to customize the replay of JSON user flow (Generate with [Chrome DevTools Recorder](https://goo.gle/devtools-recorder)) using [Puppeteer Replay](https://goo.gle/puppeteer-replay).

# Setup

1. Download the project.
1. Install dependecies: `npm install`.
1. Install puppeteer if you don't have one `npm install puppeteer`.


# Run the examples locally

The `src/screenshot-ext.js` will take screenshot after every step and save it to `_screencasts`. All JSON user flows are in the `/recordings` folder.

- Use `npm start` to run the command programmatically.
- Use `npm run replay` to run multiple recordings with Puppeteer Replay CLI.
- You can also import the JSON file into [Chrome DevTools Recorder](https://goo.gle/devtools-recorder).
- See `.github/workflows/node.js.yml` to see how to setup the user flows to run on everyday 12:30pm / commits.


# Run the examples with Google Cloud Run Job

The `src/screenshot-cloud-ext.js` will take screenshot after every step and save it to `cloud storage`. All JSON user flows are in the `/recordings` folder. 

- Register for Google Cloud and Install Cloud CLI
- Replace any variables in `./set_env_var.sh` for your need
- Run `./setup_env.sh` to setup your local Google Cloud environment
- Run `./setup_job.sh` to setup a Cloud Run Job
- Run `./setup_schedule.sh` to setup a Cloud schedule to run the job every day 12pm
- Check your cloud console

## Additional cloud scripts

- Run `./update_job.sh` to update the job details and rerun
- Run `./update_repo.sh` to update the artifact and job tag (e.g. increase the version)
- Run `./update_schedule.sh` to update the schedule to run every 5 min

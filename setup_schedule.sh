#!/bin/bash

# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source ./set_env_var.sh

echo "Grant this Service account the permission to run the Cloud Run job"
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role="roles/run.invoker"

echo "Create a Cloud Scheduler Job that will run the Cloud Run Job on schedule"
# Everyday 12pm. See: https://crontab.guru/
gcloud scheduler jobs create http ${SCHEDULE_NAME} \
    --location "${REGION}" \
    --schedule='0 12 * * *' \
    --uri=https://${REGION}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${PROJECT_ID}/jobs/${JOB_NAME}:run \
    --http-method POST \
    --oauth-service-account-email=${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
    --oauth-token-scope=https://www.googleapis.com/auth/cloud-platform

# echo "Test that Cloud Scheduler can correctly run the Cloud Run job"
# gcloud scheduler jobs run ${SCHEDULE_NAME} --location "${REGION}"

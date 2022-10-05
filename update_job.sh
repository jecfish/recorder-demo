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

echo "Configure your local gcloud to use your project and a region to use for Cloud Run"
gcloud config set project ${PROJECT_ID}
gcloud config set run/region ${REGION}

# Get recordings
no_of_recordings=$(ls $RECORDING_DIR | wc -l)
echo "Number of recordings: $no_of_recordings"

echo "Updates job"
gcloud beta run jobs update ${JOB_NAME} \
  --tasks $no_of_recordings \
  --image ${REGION}-docker.pkg.dev/${PROJECT_ID}/${CONTAINER_NAME}/${JOB_NAME}:${JOB_TAG} \
  --service-account ${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
  --task-timeout 3600 \
  --memory 1Gi \
  --command=npm,run,replay-cloud

echo "Run the Cloud Run job"
gcloud beta run jobs execute ${JOB_NAME}

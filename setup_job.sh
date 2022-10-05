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

export PROJECT_ID=$(gcloud config get-value project)
export REGION=${REGION:=europe-west3}

export BUCKET_NAME=${BUCKET_NAME:=jjjttt}
export STORAGE_REGION="EU"

export SA_NAME="ggssww-sa"

export JOB_NAME="ggdemo"
export JOB_TAG="v1"

export RECORDING_DIR="recordings/"

echo "Configure your local gcloud"
gcloud config set project ${PROJECT_ID}
gcloud config set run/region ${REGION}

echo "Create a new Artifact Registry container repository"
gcloud artifacts repositories create containers --repository-format=docker --location=${REGION}

echo "Build this repository into a container image"
gcloud builds submit -t europe-west3-docker.pkg.dev/${PROJECT_ID}/containers/${JOB_NAME}:${JOB_TAG}

# Get recordings
no_of_recordings=$(ls $RECORDING_DIR | wc -l)
echo "Number of recordings: $no_of_recordings"

echo "Build a Cloud Run job"
gcloud beta run jobs create ${JOB_NAME} \
  --tasks $no_of_recordings \
  --image ${REGION}-docker.pkg.dev/${PROJECT_ID}/containers/${JOB_NAME}:${JOB_TAG} \
  --service-account ${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
  --set-env-vars STORAGE_REGION=${STORAGE_REGION},BUCKET_NAME=${BUCKET_NAME}

echo "Run the Cloud Run job"
gcloud beta run jobs execute ${JOB_NAME}

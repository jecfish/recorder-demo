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

# Choose europe-west3 if REGION is not defined.
export REGION=${REGION:=europe-west3}

echo "Replaying on Google Cloud"

no_of_recordings=$(ls recordings/ | wc -l)
echo "Number of recordings: $no_of_recordings"

echo "Configure your local gcloud to use your project and a region to use for Cloud Run"
gcloud config set project ${PROJECT_ID}
gcloud config set run/region ${REGION}

echo "Enable required services"
gcloud services enable artifactregistry.googleapis.com run.googleapis.com cloudbuild.googleapis.com

# Create step
echo "Create a new Artifact Registry container repository"
gcloud artifacts repositories create containers --repository-format=docker --location=${REGION}

echo "Build this repository into a container image"
gcloud builds submit -t europe-west3-docker.pkg.dev/${PROJECT_ID}/containers/screenshot-demo:v1

# create step
echo "Create a service account that has no permission, this will ensure replayed user journeys cannot access any of your Google Cloud resources"
gcloud iam service-accounts create no-permission --description="No IAM permission"

# echo "Updates job"
# gcloud beta run jobs update screenshot-demo \
#   --tasks $no_of_journeys \
#   --image europe-west3-docker.pkg.dev/${PROJECT_ID}/containers/screenshot-demo:v1 \
#   --service-account no-permission@${PROJECT_ID}.iam.gserviceaccount.com

# create step
echo "Create a Cloud Run job"
gcloud beta run jobs create screenshot-demo \
  --tasks $no_of_journeys \
  --image europe-west3-docker.pkg.dev/${PROJECT_ID}/containers/screenshot-demo:v1 \
  --service-account no-permission@${PROJECT_ID}.iam.gserviceaccount.com

echo "Run the Cloud Run job"
gcloud beta run jobs execute screenshot-demo
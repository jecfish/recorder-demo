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

echo "Configure your local gcloud"
gcloud config set project ${PROJECT_ID}
gcloud config set run/region ${REGION}

echo "Create a bucket"
gcloud storage buckets create gs://${BUCKET_NAME} --project=${PROJECT_ID} --location=${STORAGE_REGION}

echo "Enable required services"
gcloud services enable artifactregistry.googleapis.com run.googleapis.com cloudbuild.googleapis.com cloudscheduler.googleapis.com

echo "Create service account"
gcloud iam service-accounts create ${SA_NAME} --description="Demo account for Recorder"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --role roles/storage.admin \
  --member serviceAccount:${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com

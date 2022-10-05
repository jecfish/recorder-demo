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

# For all Google Cloud services
export PROJECT_ID=$(gcloud config get-value project)
export REGION=${REGION:=europe-west3}

# For storage bucket
export BUCKET_NAME="user-flow-shots"
export STORAGE_REGION="EU"

# For Cloud Artifacts
export CONTAINER_NAME="recording-containers"

# For IAM
export SA_NAME="user-flow-sa"

# For Cloud Run job
export JOB_NAME="user-flow"
export JOB_TAG="v1"

# For Cloud Scheduler
export SCHEDULE_NAME="user-flow-runner"

# The location of your recordings
export RECORDING_DIR="recordings/"




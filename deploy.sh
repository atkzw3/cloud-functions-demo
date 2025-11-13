#!/bin/bash

if [ ! -f .env ]; then
  echo "Error: .env file not found. Please create .env file from env.example"
  exit 1
fi

export $(cat .env | grep -v '^#' | xargs)

if [ -z "$REGION" ] || [ -z "$SERVICE_NAME" ] || [ -z "$FUNCTION_NAME" ] || [ -z "$BASE_IMAGE" ]; then
  echo "Error: Required environment variables are not set in .env file"
  echo "Please set: REGION, SERVICE_NAME, FUNCTION_NAME, BASE_IMAGE"
  exit 1
fi
## 初回デプロイ・更新時に実行
gcloud run deploy $SERVICE_NAME \
       --source ./helloworld \
       --function $FUNCTION_NAME \
       --base-image $BASE_IMAGE \
       --region $REGION \
       --allow-unauthenticated


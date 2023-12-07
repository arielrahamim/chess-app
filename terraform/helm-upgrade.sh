#!/bin/bash

KUBECONFIG_FILE="$KUBECONFIG"
VALUES_FILE="$VALUES_FILE"
RELEASE_NAME="$RELEASE_NAME"
NAMESPACE="$NAMESPACE"
CHART_URL="$CHART_URL"
CHART_PATH="$CHART_PATH"
CHART_NAME="$CHART_NAME"

# Check if required variables are set
if [ -z "$KUBECONFIG_FILE" ] || [ -z "$VALUES_FILE" ] || [ -z "$RELEASE_NAME" ] || [ -z "$NAMESPACE" ] || [ -z "$CHART_URL" ] || [ -z "$CHART_PATH" ]; then
  echo "Usage: $0 -k=<kubeconfig_file> -f=<values_file> -c=<chart_path> -r=<release_name> -n=<namespace>"
  exit 1
fi




helm repo add "$CHART_NAME" "$CHART_URL" --kubeconfig "$KUBECONFIG_FILE"
helm upgrade -i "$RELEASE_NAME" "$CHART_NAME"/"$CHART_PATH" --namespace "$NAMESPACE" --kubeconfig "$KUBECONFIG_FILE" -f <(echo "$VALUES_FILE") --create-namespace --dependency-update






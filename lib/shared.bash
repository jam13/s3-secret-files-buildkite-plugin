#!/bin/bash

s3_bucket_exists() {
  local bucket="$1"
  if ! aws s3api head-bucket --bucket "$bucket" &>/dev/null ; then
    return 1
  fi
}

s3_download() {
  local bucket="$1"
  local key="$2"
  local dest="$3"
  local extra_args="$4"
  local aws_s3_args=("--quiet" "--region=$AWS_DEFAULT_REGION")

  if [[ "${BUILDKITE_USE_KMS:-true}" =~ ^(true|1)$ ]] ; then
    aws_s3_args+=("--sse" "aws:kms")
  fi

  if ! aws s3 cp "${aws_s3_args[@]}" $extra_args "s3://$1/$2" "$3" ; then
    exit 1
  fi

  chmod -R og-rwx "$3"
}

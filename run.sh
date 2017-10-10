#!/bin/sh
set +e


error() { printf "✖ %s\n" "$@"
}
warn() { printf "➜ %s\n" "$@"
}
success() { printf "✔ %s\n" "$@"
}
info() { printf "%s\n" "$@"
}

type_exists() {
  if [ $(type -P $1) ]; then
    return 0
  fi
  return 1
}

# Check awscli is installed
if ! type_exists 'aws'; then
  pip install -r requirements.txt
fi

# Check variables
if [ -z "$WERCKER_AWS_LAMBDA_INVOKE_KEY" ]; then
  error "Please set the 'key' variable"
  exit 1
fi
if [ -z "$WERCKER_AWS_LAMBDA_INVOKE_SECRET" ]; then
  error "Please set the 'secret' variable"
  exit 1
fi
if [ -z "$WERCKER_AWS_LAMBDA_INVOKE_REGION" ]; then
  error "Please set the 'region' variable"
  exit 1
fi
if [ -z "$WERCKER_AWS_LAMBDA_INVOKE_FUNCTION_NAME" ]; then
  error "Please set the 'function-name' variable"
  exit 1
fi
if [ -z "$WERCKER_AWS_LAMBDA_INVOKE_PAYLOAD" ]; then
  error "Please set the 'payload' variable"
  exit 1
fi
set -e

export AWS_ACCESS_KEY_ID="${WERCKER_AWS_LAMBDA_INVOKE_KEY}"
export AWS_SECRET_ACCESS_KEY="${WERCKER_AWS_LAMBDA_INVOKE_SECRET}"
export AWS_DEFAULT_REGION="${WERCKER_AWS_LAMBDA_INVOKE_REGION}"

aws lambda invoke --function-name "${WERCKER_AWS_LAMBDA_INVOKE_FUNCTION_NAME}" --payload \'${WERCKER_AWS_LAMBDA_INVOKE_PAYLOAD}\' /dev/null

#!/bin/bash

usage() {
  echo "Usage:"
  echo "s3.sh <your-ng2-repo> <aws-repo>"
  echo ""
}

if [ -z $1 ]; then usage; exit 0; fi

set -u
set -e

PROJECT_DIR="$1"
AWS_DIR="$2"
BUILDS_DIR="$AWS_DIR/builds"
TIMESTAMP=`date +"%m%d-%H%M%S"`

mkdir -p ${BUILDS_DIR}

cd ${PROJECT_DIR}

npm run build

tar -czf "$BUILDS_DIR/dist.$TIMESTAMP.tar.gz" "$AWS_DIR/public"
rm -rf "$AWS_DIR/public"

mv -vf dist "$AWS_DIR/public"

cd ${AWS_DIR}
git checkout -B master origin/master
git add .
git commit -m "build: $TIMESTAMP"
git push

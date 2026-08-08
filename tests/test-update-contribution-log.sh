#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_PATH="${ROOT_DIR}/scripts/update-contribution-log.sh"

if [[ ! -x "${SCRIPT_PATH}" ]]; then
  echo "Expected executable script at ${SCRIPT_PATH}" >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

cp -R "${ROOT_DIR}/scripts" "${TMP_DIR}/scripts"
cd "${TMP_DIR}"

CHECK_IN_DATE="2026-07-15" \
CHECK_IN_TIMESTAMP="2026-07-15 09:17:00 CST" \
  bash scripts/update-contribution-log.sh

if [[ ! -f activity/contribution-log.csv ]]; then
  echo "Expected activity/contribution-log.csv to be created" >&2
  exit 1
fi

expected_header="date,timestamp,note"
actual_header="$(sed -n '1p' activity/contribution-log.csv)"
if [[ "${actual_header}" != "${expected_header}" ]]; then
  echo "Unexpected CSV header: ${actual_header}" >&2
  exit 1
fi

first_count="$(grep -c '^2026-07-15,' activity/contribution-log.csv)"
if [[ "${first_count}" != "1" ]]; then
  echo "Expected one 2026-07-15 row after first run, got ${first_count}" >&2
  exit 1
fi

CHECK_IN_DATE="2026-07-15" \
CHECK_IN_TIMESTAMP="2026-07-15 20:37:00 CST" \
  bash scripts/update-contribution-log.sh

second_count="$(grep -c '^2026-07-15,' activity/contribution-log.csv)"
if [[ "${second_count}" != "1" ]]; then
  echo "Expected idempotent second run, got ${second_count} rows" >&2
  exit 1
fi

echo "update-contribution-log tests passed"

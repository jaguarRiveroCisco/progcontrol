#!/usr/bin/env bash

# Default values
seconds=30
verbose=1

# Parse command-line options
while getopts ":s:v:" opt; do
  case $opt in
    s)
      seconds=$OPTARG
      ;;
    v)
      verbose=$OPTARG
      ;;
    *)
      echo "Usage: $0 -s <number of seconds> -v <0 or 1>"
      exit 1
      ;;
  esac
done

pid=$$
parent_pid=$PPID

if [ "$verbose" -eq 1 ]; then
  echo "Lengthy process started with PID $pid. Sleeping for $seconds seconds..."
fi

# Sleep with a progress indicator
for ((i = 0; i < seconds; i++)); do
  if ! kill -0 "$parent_pid" 2>/dev/null; then
    if [ "$verbose" -eq 1 ]; then
      echo "Parent process died. Exiting. PID $pid"
    fi
    break
  fi
  if [ "$verbose" -eq 1 ]; then
    echo "Progress: $((i + 1)) seconds elapsed. PID $pid"
  fi
  sleep 1
done

if [ "$verbose" -eq 1 ]; then
  echo "Lengthy process completed. PID $pid"
fi
#!/bin/bash

intelUsage=$(cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo "0")
intelTemp=$(sensors 2>/dev/null | grep "Package id" | awk '{print $4}' | sed 's/+//;s/°C//;s/\..*//' || echo "0")

nvidiaUsage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo "0")
nvidiaTemp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null || echo "0")

echo "GPU0: $nvidiaUsage% (${nvidiaTemp}°C) | GPU1: $intelUsage% (${intelTemp}°C)"

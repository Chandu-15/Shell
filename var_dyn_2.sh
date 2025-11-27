#!/bin/bash
start_time=$(date +%s)
sleep 10
end_time=$(date +%s)
total_time=$(($end_time - $start_time))
echo "Script executed in $total_time seconds"

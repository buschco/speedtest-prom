#!/bin/bash

[[ -z "${SERVER_ID}" ]] && server_id_arg='' || server_id_arg="${DEPLOY_ENV}"

speedtest_result=$(speedtest --format=json --accept-license --accept-gdpr "$server_id_arg")

download=$(printf "%s" "$speedtest_result" | jq '.download.bandwidth * 8 / 1000000')
upload=$(printf "%s" "$speedtest_result" | jq '.upload.bandwidth     * 8 / 1000000')
ping=$(printf "%s" "$speedtest_result" | jq '.ping.latency')

printf "
# TYPE speedtest_megabits_per_second gauge
# HELP speedtest_megabits_per_second Speed measured in megabits per second
speedtest_megabits_per_second{direction="downstream"} %f
speedtest_megabits_per_second{direction="upstream"} %f
# TYPE speedtest_ping gauge
# HELP speedtest_ping Ping in ms
speedtest_ping %f
" $download $upload $ping

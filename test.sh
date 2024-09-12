
a='{"test":{"prevVer":"0.0.0", "newVer": "1.0.0"},"test1":{"prevVer":"0.0.0", "newVer": "1.0.0"}}'

jq -r '."test.prevVer' <<< "$a"

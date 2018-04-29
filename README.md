# memory_check
SE Exercise | scripting using BASH 

Usage example:
mem-check (-c|--critical) char (-w|--warning) char (-e|--email) char
Options:
-c or --critical char: Threshold. Required.
-w or --warning char: Threshold. Required.
-e or --email char: Email. Required.

Note: If you want to test if it is working. kindly lower the value of the threshold on the script to the current memory usage of your machine

"if [[ "$used" -gt XXX || "$used" -eq XXX ]]; then ###90% or 100% of 1024"

This script by default will send notification to my email which is defined on the script.

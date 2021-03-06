#!/bin/sh -x

# Runs Sacla Pi in the examples, with 12 nodes (1 master + 11
# workers), NOT using "rank"-directories.

#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "node=12"
#PJM --rsc-list "elapse=00:06:00"
#PJM -S
#PJM --stgout "./spark.logs/* ./%n.z%j/"
#PJM --stg-transfiles "all"

. /work/system/Env_base > /dev/null

k_scripts=/opt/aics/spark/scripts/
. ${k_scripts}/spark-k-config.sh
. ${k_scripts}/spark-k-functions.sh

spark_k_setup
spark_k_start_all

${SPARK_HOME}/bin/spark-submit \
    --class org.apache.spark.examples.SparkPi \
    --master "${k_master_url}" \
    ${SPARK_HOME}/lib/spark-examples-1.6.2-hadoop2.2.0.jar

spark_k_stop_all
spark_k_clean

sleep 20

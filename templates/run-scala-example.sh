#!/bin/sh

#PJM --rsc-list "node=48"
#PJM --rsc-list "elapse=00:30:00"
#PJM --rsc-list "rscgrp=small"
#PJM --mpi "use-rankdir"
#PJM -s

# Remove '#COMMENT OUT#' if yo
#COMMENT_OUT#PJM --stgin "rank=0 ./spark-k-initialize 0:."
#COMMENT_OUT#PJM --stgin "rank=0 ./spark-k-finalize 0:."
#COMMENT_OUT#PJM --stgin "rank=0 ./spark-k-initialize 0:."
#COMMENT_OUT#PJM --stgin "rank=0 ./spark-k-initialize 0:."

#PJM --stg-transfiles "all"

SPARK_K_PATH=.

. ${SPARK_K_PATH}/spark-k-initialize

${SPARK_HOME}/bin/spark-submit \
    --master ${SPARK_MASTER} \
    --class org.apache.spark.examples.SparkPi \
    ${SPARK_HOME}/lib/spark-examples-1.6.0-hadoop2.2.0.jar

. ${SPARK_K_PATH}/spark-k-finalize

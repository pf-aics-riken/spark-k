#!/bin/sh -x

# Runs SimpleApp from a locally built jar file.  SimpleApp in Scala,
# Java, and Python are taken from
# http://spark.apache.org/docs/latest/quick-start.html.  It runs with
# 12 nodes (1 master + 11 workers), using "rank"-directory.

# To build a jar file for Scala, run make in the "scala" directory.
# The source code is "scala/src/main/scala/SimpleApp.scala".  It
# assumes Scala-2.11 and SBT are installed.

# To build a jar file for Java, run make in the "java" directory.  The
# source code is "java/src/main/java/SimpleApp.java".  It assumes MVN
# is installed.

#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "node=12"
#PJM --rsc-list "elapse=00:10:00"
#PJM --mpi "use-rankdir"
#PJM -S
#PJM --stgin "rank=* ./scala/target/scala-2.11/simple-project_2.11-1.0.jar %r:./"
#PJM --stgin "rank=* ./java/target/simple-project-1.0.jar %r:./"
#PJM --stgin "rank=* ./python/SimpleApp.py %r:./"
#PJM --stgout "rank=* %r:./spark.logs/* ./%n.z%j/"
#PJM --stg-transfiles "all"

. /work/system/Env_base > /dev/null

k_scripts=/opt/aics/spark/scripts/
. ${k_scripts}/spark-k-config.sh
. ${k_scripts}/spark-k-functions.sh

spark_k_setup
spark_k_start_all

(sleep 5; echo ""; echo "*** RUNNING SimpleApp.scala... ***"; echo "")

${SPARK_HOME}/bin/spark-submit \
    --master "${k_master_url}" \
    --class "SimpleApp" \
    ./simple-project_2.11-1.0.jar

(sleep 5; echo ""; echo "*** RUNNING SimpleApp.java... ***"; echo "")

${SPARK_HOME}/bin/spark-submit \
    --master "${k_master_url}" \
    --class "SimpleApp" \
    ./simple-project-1.0.jar

(sleep 5; echo ""; echo "*** RUNNING SimpleApp.py... ***"; echo "")

${SPARK_HOME}/bin/spark-submit \
    --master "${k_master_url}" \
    ./SimpleApp.py

spark_k_stop_all
spark_k_clean

sleep 20

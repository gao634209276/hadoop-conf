## profile edit each version to set base bash env

export HADOOP_HOME=/app/sinova/hadoop-2.5.2
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HIVE_HOME=/app/sinova/hive-0.14.0
export HBASE_HOME=/app/sinova/hbase-0.98.9
export SPARK_HOME=/app/sinova/spark-2.0.2
export ZOOKEEPER_HOME=/app/sinova/zookeeper-3.4.6

#PATH=$PATH:
export HBASE_HOME=/app/noah/hbase-1.2.1
export ZOOKEEPER_HOME=/app/noah/zookeeper-3.4.8


# export MAHOUT_HOME=/opt/modules/mahout-0.12.0
# export MAHOUT_LOCAL=true

# export FLUME_HOME=/opt/modules/flume-1.6.0
# export KAFKA_HOME=/opt/modules/kafka
# export SPARK_HOME=/opt/modules/spark-1.6.1
# export SPARK_HOME=/opt/modules/spark-2.0.2
# export STORM_HOME=/opt/modules/storm-1.0.1

PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$ZOOKEEPER_HOME/bin:$HBASE_HOME/bin:$SPARK_HOME/bin

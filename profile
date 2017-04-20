## profile edit each version to set base bash env

export JAVA_HOME=/usr/local/java/jdk1.7.0_80
export HADOOP_HOME=/app/noah/hadoop-2.7.2
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HIVE_HOME=/app/noah/hive-1.2.1
export HBASE_HOME=/app/noah/hbase-1.2.1
export ZOOKEEPER_HOME=/app/noah/zookeeper-3.4.8


# export MAHOUT_HOME=/opt/modules/mahout-0.12.0
# export MAHOUT_LOCAL=true

# export FLUME_HOME=/opt/modules/flume-1.6.0
# export KAFKA_HOME=/opt/modules/kafka
# export SPARK_HOME=/opt/modules/spark-1.6.1
# export SPARK_HOME=/opt/modules/spark-2.0.2
# export STORM_HOME=/opt/modules/storm-1.0.1

PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$ZOOKEEPER_HOME/bin

# :$SPARK_HOME/bin:$STORM_HOME/bin:$KAFKA_HOME/bin:$SQOOP_HOME/bin:$MAHOUT_HOME/bin:/opt/modules/openresty/nginx/sbin:$ELASTICSEARCH_HOME/bin:/home/hadoop/sinova/vpn:/home/hadoop/sinova/bin


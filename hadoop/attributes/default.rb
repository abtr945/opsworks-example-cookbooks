default[:Hadoop][:Core][:hadoopNamenodeDir] = "/home/hduser/hdfs/namenode"
default[:Hadoop][:Core][:hadoopDatanodeDir] = "/home/hduser/hdfs/datanode"
override[:java][:install_flavor] = "oracle"
override[:java][:oracle][:accept_oracle_download_terms] = true
override[:java][:jdk_version] = "7"

com.facebook.presto.jdbc.PrestoDriver
presto://10.20.11.17:8000/hive/default
user=test
passwd=

http://blog.csdn.net/jiangshouzhuang/article/details/52461274
下载地址:
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-server/
注意从0.86版本后只支持Java 8，这里使用0.85版本+java 7，不然会出现
最新0.183版本
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.183/presto-server-0.183.tar.gz
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-server/0.182/presto-server-0.182.tar.gz
生产0.85版本
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.85/presto-server-0.85.tar.gz

jdbc:
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-jdbc/0.182/presto-jdbc-0.182.jar
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-jdbc/0.85/presto-jdbc-0.85.jar
部署文档:
https://prestodb.io/docs/current/installation/deployment.html

-----------------------------------------------------------------
运行Presto
在安装目录的bin/launcher文件，就是启动脚本。Presto可以使用如下命令作为一个后台进程启动：
	bin/launcher start
另外，也可以在前台运行，日志和相关输出将会写入stdout/stderr（可以使用类似daemontools的工具捕捉这两个数据流）：
	bin/launcher run
运行bin/launcher --help，Presto将会列出支持的命令和命令行选项。另外可以通过运行时使用—verbose参数，来调试安装是否正确。
启动完之后，日志将会写在node.data-dir 配置目录的子目录var/log下，该目录下有如下文件：
	launcher.log：
	这个日志文件由launcher创建，并且server的stdout和stderr都被重定向到了这个日志文件中。
	这份日志文件中只会有很少的信息，包括：在server日志系统初始化的时候产生的日志和JVM产生的诊断和测试信息。
	server.log：
	这个是Presto使用的主要日志文件。一般情况下，该文件中将会包括server初始化失败时产生的相关信息。这份文件会被自动轮转和压缩。
	http-request.log：
	这是HTTP请求的日志文件，包括server收到的每个HTTP请求信息，这份文件会被自动轮转和压缩。

-----------------------------------------------------------------
命令行接口访问Presto
Presto CLI为用户提供了一个用于查询的可交互终端窗口。CLI是一个 可执行 JAR文件, 这也就意味着你可以像UNIX终端窗口一样来使用CLI。
下载 presto-cli-0.152-executable.jar，重名名为 presto ，使用 chmod +x 命令设置可执行权限，然后执行：
	./presto --server example.net:8080 --catalog hive --schema default
	使用 --help 选项运行CLI，可以看到可用的选项。
默认情况下，查询的结果是分页的。而这种分页的实现不需要你去编写什么代码，而是通过配置一系列的配置信息来实现的。
你也可以通过将环境变量：
	PRESTO_PAGER 设置为你自己的程序名称（比如less，more）来自己实现分页或者也可以PRESTO_PAGER 的值设置为空，从而禁止分页。
示例如下：
	presto  --server SZB-L0023780:8080 --catalog hive--schema default
	presto:default>use zy_af_db;
	presto: zy_af_db>select count(1) from ps_of_all;
	   _col0
    -----------
     256656293
    (1 row)
    Query20160907_030802_00014_kr9n9, FINISHED, 2 nodes
    Splits:828 total, 828 done (100.00%)
    0:03 [257M rows, 55GB] [78.7M rows/s, 16.9GB/s]

-----------------------------------------------------------------
JDBC驱动访问Presto
通过使用JDBC驱动，可以访问Presto。
	下载presto-jdbc-0.152.jar并将这个jar文件添加到你的java应用程序的classpath中，Presto支持的URL格式如下：
	jdbc:presto://host:port
	jdbc:presto://host:port/catalog
	jdbc:presto://host:port/catalog/schema
例如，可以使用下面的URL来连接运行在example.NET服务器8080端口上的Presto的hive catalog中的sales schema：
	jdbc:presto://example.net:8080/hive/sales

-----------------------------------------------------------------
Presto校验器

我们可以使用Presto Verifier 来将Presto与其他的数据库（例如：MySQL）进行对比测试或者将两个Presto集群相互进行对比测试。
如果我们需要对Presto进行二次开发，那么我们将会使用Presto Verifier不间断的与Presto的前一版本进行对比测试。
	第一步：创建一个mysql数据库，并且在数据库中用如下语句创建一个表：
		CREATE TABLE verifier_queries(
		    id INT NOT NULL AUTO_INCREMENT,
		    suite VARCHAR(256) NOT NULL,
		    name VARCHAR(256),
		    test_catalog VARCHAR(256) NOT NULL,
		    test_schema VARCHAR(256) NOT NULL,
		    test_prequeries TEXT,
		    test_query TEXT NOT NULL,
		    test_postqueries TEXT,
		    test_username VARCHAR(256) NOT NULL default 'verifier-test',
		    test_password VARCHAR(256),
		    control_catalog VARCHAR(256) NOT NULL,
		    control_schema VARCHAR(256) NOT NULL,
		    control_prequeries TEXT,
		    control_query TEXT NOT NULL,
		    control_postqueries TEXT,
		    control_username VARCHAR(256) NOT NULL default 'verifier-test',
		control_password VARCHAR(256),
		session_properties_json VARCHAR(256),
		    PRIMARY KEY (id)
		);
	第二步，创建一个属性文件，通过该属性文件来配置校验器：
		suite=my_suite
		query-database=jdbc:mysql://localhost:3306/my_database?user=my_username&password=my_password
		control.gateway=jdbc:presto://localhost:8080
		test.gateway=jdbc:presto://localhost:8081
		thread-count=1
	最后一步, 下载presto-verifier-0.152-executable.jar，并将其重命名为：verifier，
	通过命令：chmod +x为其赋予执行权限，然后运行：
		./verifier config.properties


-----------------------------------------------------------------
Web接口管理Presto
Presto提供了一个Web接口用于监控和管理查询。
这个Web接口可以在Presto coordinator上通过HTTP访问，使用在etc/config.properties中配置的HTTP端口号。
主页面显示了正在执行的查询数，正常活动的Worker数，排队的查询数，阻塞的查询数，并行度等等，
以及每个查询的列表区域（包括查询的ID，查询语句，查询状态，用户名，数据源等等）。
正在查询的排在最上面，紧接着依次为最近完成的查询，失败的查询等。
	查询的状态有以下几种：
	·        QUEUED – 查询以及被接受，正等待执行
	·        PLANNING – 查询在计划中
	·        STARTING – 查询已经开始执行
	·        RUNNING – 查询已经运行，至少有一个task开始执行
	·        BLOCKED – 查询被阻塞，并且在等待资源（缓存空间，内存，切片）
	·        FINISHING – 查询正完成（比如commit forautocommit queries）
	·        FINISHED – 查询已经完成（比如数据已经输出）
	·        FAILED – 查询执行失败
	如果你想查看一个查询更加详细信息，只要点击该查询的“Query ID”链接即可，部分内容如下：
	每个查询中的Tasks，我们可以单击“ID”查询每个Task更多的信息。

查询的总概览中提供了一个“Kill Query”功能，另外也提供了三种可视化的功能，为Live Plan，Raw JSON和Split Timeline。
比如我们可以从Split Timelinez中查询哪部分耗时比较多。

-----------------------------------------------------------------
Presto调优
默认的Presto配置满足绝大部分的负载要求，下面的一些信息会帮助你解决Presto集群环境中的一些特殊的性能问题。
配置文件
	task.info-refresh-max-wait
		控制过期task信息，使用在调度中。增加这个值能够减少coordinator 的CPU负载，但是可能导致split调度不是最优的。
	task.max-worker-threads
		设置workers处理splits时使用的线程数。
		如果Worker的CPU利用率低并且所有的线程都在使用，那么增加这个值可以提高吞吐量，但是会增加堆内存空间大小。
		活动线程的数量可以通过com.facebook.presto.execution.taskexecutor.runningsplitsJMX统计
	distributed-joins-enabled
		使用hash分布式join代替broadcast广播的join。
		分布式join需要根据join key的hash值来重新分布表，这可能比广播join慢，但是可以利用更大的表之间join操作。
		广播的join需要关接的右边的表加载到每一个节点的内存中，然而分布式join是将关联的右边的表加载到分布式内存中。
		我们可以在每一个查询中设置distributed_join 的session属性值来进行选择。
	node-scheduler.network-topology
		当调度split时，设置使用的网络拓扑。
		当调度split时，“legacy”将忽略拓扑，“flat”将尝试在同一个节点调度split。

JVM配置
下面的参数可以帮助诊断GC问题：
	-XX:+PrintGCApplicationConcurrentTime
	-XX:+PrintGCApplicationStoppedTime
	-XX:+PrintGCCause
	-XX:+PrintGCDateStamps
	-XX:+PrintGCTimeStamps
	-XX:+PrintGCDetails
	-XX:+PrintReferenceGC
	-XX:+PrintClassHistogramAfterFullGC
	-XX:+PrintClassHistogramBeforeFullGC
	-XX:PrintFLSStatistics=2
	-XX:+PrintAdaptiveSizePolicy
	-XX:+PrintSafepointStatistics
	-XX:PrintSafepointStatisticsCount=1

队列配置
队列规则定义在一个Json文件中，用于控制能够提交给Presto的查询的个数，以及每个队列中能够同时运行的查询的个数。
用config.properties中的query.queue-config-file来指定Json配置文件的名字。

队列规则如果定义了多个队列，查询会按顺序依次进入不同的队列中。
队列规则将按照顺序进行处理，并且使用第一个匹配上的规则。
在以下的配置例子中，有5个队列模板，在user.${USER}队列中，${USER}表示着提交查询的用户名。
同样的${SOURCE}表示提交查询的来源。
同样有如下的规则定义了哪一类查询会进入哪一个队列中：
	· 第一条规则将使bob成为管理员，bob提交的查询进入admin队列。
	· 第二条规则表示，来源包含pipeline的查询将首先进入用户的个人队列中，然后进入pipeline队列。
		当一个查询进入一个新的队列后，直到查询结束才会离开之前的队列。
	· 最后一个规则包含所有的队列，将所有的查询加入到个人用户队列中

所有这些规则实现了这样的策略，bob是一个管理员，而其他用户需要遵循以下的限制：
	1.每个用户最多能同时运行5个查询，另外可以运行一个pipeline。
	2.最多能同时运行10个pipeline来源的查询。
	3.最多能同时运行100个其他查询。
	{
	  "queues": {
	    "user.${USER}": {
	      "maxConcurrent": 5,
	      "maxQueued": 20
	    },
	    "user_pipeline.${USER}": {
	      "maxConcurrent": 1,
	      "maxQueued": 10
	    },
	    "pipeline": {
	      "maxConcurrent": 10,
	      "maxQueued": 100
	    },
	    "admin": {
	      "maxConcurrent": 100,
	      "maxQueued": 100
	    },
	    "global": {
	      "maxConcurrent": 100,
	      "maxQueued": 1000
	    }
	  },
	  "rules": [
	    {
	      "user": "bob",
	      "queues": ["admin"]
	    },
	    {
	      "source": ".*pipeline.*",
	      "queues": [
	        "user_pipeline.${USER}",
	        "pipeline",
	        "global"
	      ]
	    },
	    {
	      "queues": [
	        "user.${USER}",
	        "global"
	      ]
	    }
	  ]
	}
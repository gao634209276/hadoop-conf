com.facebook.presto.jdbc.PrestoDriver
presto://10.20.11.17:8000/hive/default
user=test
passwd=

http://blog.csdn.net/jiangshouzhuang/article/details/52461274
���ص�ַ:
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-server/
ע���0.86�汾��ֻ֧��Java 8������ʹ��0.85�汾+java 7����Ȼ�����
����0.183�汾
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.183/presto-server-0.183.tar.gz
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-server/0.182/presto-server-0.182.tar.gz
����0.85�汾
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.85/presto-server-0.85.tar.gz

jdbc:
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-jdbc/0.182/presto-jdbc-0.182.jar
http://maven.aliyun.com/nexus/content/groups/public/com/facebook/presto/presto-jdbc/0.85/presto-jdbc-0.85.jar
�����ĵ�:
https://prestodb.io/docs/current/installation/deployment.html

-----------------------------------------------------------------
����Presto
�ڰ�װĿ¼��bin/launcher�ļ������������ű���Presto����ʹ������������Ϊһ����̨����������
	bin/launcher start
���⣬Ҳ������ǰ̨���У���־������������д��stdout/stderr������ʹ������daemontools�Ĺ��߲�׽����������������
	bin/launcher run
����bin/launcher --help��Presto�����г�֧�ֵ������������ѡ��������ͨ������ʱʹ�á�verbose�����������԰�װ�Ƿ���ȷ��
������֮����־����д��node.data-dir ����Ŀ¼����Ŀ¼var/log�£���Ŀ¼���������ļ���
	launcher.log��
	�����־�ļ���launcher����������server��stdout��stderr�����ض����������־�ļ��С�
	�����־�ļ���ֻ���к��ٵ���Ϣ����������server��־ϵͳ��ʼ����ʱ���������־��JVM��������ϺͲ�����Ϣ��
	server.log��
	�����Prestoʹ�õ���Ҫ��־�ļ���һ������£����ļ��н������server��ʼ��ʧ��ʱ�����������Ϣ������ļ��ᱻ�Զ���ת��ѹ����
	http-request.log��
	����HTTP�������־�ļ�������server�յ���ÿ��HTTP������Ϣ������ļ��ᱻ�Զ���ת��ѹ����

-----------------------------------------------------------------
�����нӿڷ���Presto
Presto CLIΪ�û��ṩ��һ�����ڲ�ѯ�Ŀɽ����ն˴��ڡ�CLI��һ�� ��ִ�� JAR�ļ�, ��Ҳ����ζ���������UNIX�ն˴���һ����ʹ��CLI��
���� presto-cli-0.152-executable.jar��������Ϊ presto ��ʹ�� chmod +x �������ÿ�ִ��Ȩ�ޣ�Ȼ��ִ�У�
	./presto --server example.net:8080 --catalog hive --schema default
	ʹ�� --help ѡ������CLI�����Կ������õ�ѡ�
Ĭ������£���ѯ�Ľ���Ƿ�ҳ�ġ������ַ�ҳ��ʵ�ֲ���Ҫ��ȥ��дʲô���룬����ͨ������һϵ�е�������Ϣ��ʵ�ֵġ�
��Ҳ����ͨ��������������
	PRESTO_PAGER ����Ϊ���Լ��ĳ������ƣ�����less��more�����Լ�ʵ�ַ�ҳ����Ҳ����PRESTO_PAGER ��ֵ����Ϊ�գ��Ӷ���ֹ��ҳ��
ʾ�����£�
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
JDBC��������Presto
ͨ��ʹ��JDBC���������Է���Presto��
	����presto-jdbc-0.152.jar�������jar�ļ���ӵ����javaӦ�ó����classpath�У�Presto֧�ֵ�URL��ʽ���£�
	jdbc:presto://host:port
	jdbc:presto://host:port/catalog
	jdbc:presto://host:port/catalog/schema
���磬����ʹ�������URL������������example.NET������8080�˿��ϵ�Presto��hive catalog�е�sales schema��
	jdbc:presto://example.net:8080/hive/sales

-----------------------------------------------------------------
PrestoУ����

���ǿ���ʹ��Presto Verifier ����Presto�����������ݿ⣨���磺MySQL�����жԱȲ��Ի��߽�����Presto��Ⱥ�໥���жԱȲ��ԡ�
���������Ҫ��Presto���ж��ο�������ô���ǽ���ʹ��Presto Verifier����ϵ���Presto��ǰһ�汾���жԱȲ��ԡ�
	��һ��������һ��mysql���ݿ⣬���������ݿ�����������䴴��һ����
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
	�ڶ���������һ�������ļ���ͨ���������ļ�������У������
		suite=my_suite
		query-database=jdbc:mysql://localhost:3306/my_database?user=my_username&password=my_password
		control.gateway=jdbc:presto://localhost:8080
		test.gateway=jdbc:presto://localhost:8081
		thread-count=1
	���һ��, ����presto-verifier-0.152-executable.jar��������������Ϊ��verifier��
	ͨ�����chmod +xΪ�丳��ִ��Ȩ�ޣ�Ȼ�����У�
		./verifier config.properties


-----------------------------------------------------------------
Web�ӿڹ���Presto
Presto�ṩ��һ��Web�ӿ����ڼ�غ͹����ѯ��
���Web�ӿڿ�����Presto coordinator��ͨ��HTTP���ʣ�ʹ����etc/config.properties�����õ�HTTP�˿ںš�
��ҳ����ʾ������ִ�еĲ�ѯ�����������Worker�����ŶӵĲ�ѯ���������Ĳ�ѯ�������жȵȵȣ�
�Լ�ÿ����ѯ���б����򣨰�����ѯ��ID����ѯ��䣬��ѯ״̬���û���������Դ�ȵȣ���
���ڲ�ѯ�����������棬����������Ϊ�����ɵĲ�ѯ��ʧ�ܵĲ�ѯ�ȡ�
	��ѯ��״̬�����¼��֣�
	��        QUEUED �C ��ѯ�Լ������ܣ����ȴ�ִ��
	��        PLANNING �C ��ѯ�ڼƻ���
	��        STARTING �C ��ѯ�Ѿ���ʼִ��
	��        RUNNING �C ��ѯ�Ѿ����У�������һ��task��ʼִ��
	��        BLOCKED �C ��ѯ�������������ڵȴ���Դ������ռ䣬�ڴ棬��Ƭ��
	��        FINISHING �C ��ѯ����ɣ�����commit forautocommit queries��
	��        FINISHED �C ��ѯ�Ѿ���ɣ����������Ѿ������
	��        FAILED �C ��ѯִ��ʧ��
	�������鿴һ����ѯ������ϸ��Ϣ��ֻҪ����ò�ѯ�ġ�Query ID�����Ӽ��ɣ������������£�
	ÿ����ѯ�е�Tasks�����ǿ��Ե�����ID����ѯÿ��Task�������Ϣ��

��ѯ���ܸ������ṩ��һ����Kill Query�����ܣ�����Ҳ�ṩ�����ֿ��ӻ��Ĺ��ܣ�ΪLive Plan��Raw JSON��Split Timeline��
�������ǿ��Դ�Split Timelinez�в�ѯ�Ĳ��ֺ�ʱ�Ƚ϶ࡣ

-----------------------------------------------------------------
Presto����
Ĭ�ϵ�Presto����������󲿷ֵĸ���Ҫ�������һЩ��Ϣ���������Presto��Ⱥ�����е�һЩ������������⡣
�����ļ�
	task.info-refresh-max-wait
		���ƹ���task��Ϣ��ʹ���ڵ����С��������ֵ�ܹ�����coordinator ��CPU���أ����ǿ��ܵ���split���Ȳ������ŵġ�
	task.max-worker-threads
		����workers����splitsʱʹ�õ��߳�����
		���Worker��CPU�����ʵͲ������е��̶߳���ʹ�ã���ô�������ֵ������������������ǻ����Ӷ��ڴ�ռ��С��
		��̵߳���������ͨ��com.facebook.presto.execution.taskexecutor.runningsplitsJMXͳ��
	distributed-joins-enabled
		ʹ��hash�ֲ�ʽjoin����broadcast�㲥��join��
		�ֲ�ʽjoin��Ҫ����join key��hashֵ�����·ֲ�������ܱȹ㲥join�������ǿ������ø���ı�֮��join������
		�㲥��join��Ҫ�ؽӵ��ұߵı���ص�ÿһ���ڵ���ڴ��У�Ȼ���ֲ�ʽjoin�ǽ��������ұߵı���ص��ֲ�ʽ�ڴ��С�
		���ǿ�����ÿһ����ѯ������distributed_join ��session����ֵ������ѡ��
	node-scheduler.network-topology
		������splitʱ������ʹ�õ��������ˡ�
		������splitʱ����legacy�����������ˣ���flat����������ͬһ���ڵ����split��

JVM����
����Ĳ������԰������GC���⣺
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

��������
���й�������һ��Json�ļ��У����ڿ����ܹ��ύ��Presto�Ĳ�ѯ�ĸ������Լ�ÿ���������ܹ�ͬʱ���еĲ�ѯ�ĸ�����
��config.properties�е�query.queue-config-file��ָ��Json�����ļ������֡�

���й�����������˶�����У���ѯ�ᰴ˳�����ν��벻ͬ�Ķ����С�
���й��򽫰���˳����д�������ʹ�õ�һ��ƥ���ϵĹ���
�����µ����������У���5������ģ�壬��user.${USER}�����У�${USER}��ʾ���ύ��ѯ���û�����
ͬ����${SOURCE}��ʾ�ύ��ѯ����Դ��
ͬ�������µĹ���������һ���ѯ�������һ�������У�
	�� ��һ������ʹbob��Ϊ����Ա��bob�ύ�Ĳ�ѯ����admin���С�
	�� �ڶ��������ʾ����Դ����pipeline�Ĳ�ѯ�����Ƚ����û��ĸ��˶����У�Ȼ�����pipeline���С�
		��һ����ѯ����һ���µĶ��к�ֱ����ѯ�����Ż��뿪֮ǰ�Ķ��С�
	�� ���һ������������еĶ��У������еĲ�ѯ���뵽�����û�������

������Щ����ʵ���������Ĳ��ԣ�bob��һ������Ա���������û���Ҫ��ѭ���µ����ƣ�
	1.ÿ���û������ͬʱ����5����ѯ�������������һ��pipeline��
	2.�����ͬʱ����10��pipeline��Դ�Ĳ�ѯ��
	3.�����ͬʱ����100��������ѯ��
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
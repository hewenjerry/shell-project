1. 从JDK中将tools.jar拷贝到一个合适的目录 (如. /tmp)；
2. 从JDK中将libattach.so也拷贝到上面的目录中(Ex. /tmp) - 这个文件，要根据当前运行系统的操作系统位数进行选择，如32位或64位，我们就需要从合适的JDK中进行选择文件；
3. 修改Btrace的脚本，脚本是在bin目录下面，根据不同的系统修改不同的btrace文件 - 将TOOLS_JAR="${JAVA_HOME}/lib/tools.jar"修改为指向上面拷贝的tools.jar；
4. 修改Btrace的脚本，脚本是在bin目录下面，根据不同的系统修改不同的btrace文件 - 修改java执行的那一行 (i.e. 就是以 $JAVA_HOME}/bin/java 开头的行) ，在其中加入参数-Djava.library.path=/tmp，/tmp目录就是我们上面存放libattach.so文件地方；
5. 照原来的执行方式执行即可。 
6. 运行的命令：
sh ./btrace/bin/btrace -cp /data/webapps/hehua-mis/WEB-INF/classes:/data/webapps/hehua-mis/WEB-INF/lib/hehua-order-1.0-20141029.123550-169.jar 21557 DAOTimes.java

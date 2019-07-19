
JAVA_HOME=../jdk-12.0.1/
NETTY_HOME=../netty-4.1.37.Final/jar/all-in-one/

#in cygwin ,only sun java for windows can be used. so path is a problem 
# jdk on windows should be like this style : 
# .;F:\MyLife\Self\Java\netty-4.1.37.Final\jar\all-in-one\netty-all-4.1.37.Final.jar
# but cygwin should look like this style:
# .:/cygdrive/f/MyLife/Self/Java/netty-4.1.37.Final/jar/all-in-one/netty-all-4.1.37.Final.jar
# cygpath --absolute --windows "$JAVA_HOME"
# cygpath --path --windows "$CLASSPATH"
# and cannot use java -cp $PATH_DIR to run class file
##
# 	cygpath --absolute --windows "$JAVA_HOME"
#	cygpath --absolute --windows "$JRE_HOME"
#	cygpath --absolute --windows "$CATALINA_HOME"
#	cygpath --absolute --windows "$CATALINA_BASE"
#	cygpath --absolute --windows "$CATALINA_TMPDIR"
#	cygpath --absolute --windows "$JSSE_HOME"
#	cygpath --path --windows "$JAVA_ENDORSED_DIRS"
#	cygpath --path --windows "$CLASSPATH"

all:echo_demo discard_demo

ECHO_OBJS = $(patsubst src/exam/echo/%.java,class/exam/echo/%.class, $(wildcard src/exam/echo/*.java))
echo_demo:${ECHO_OBJS}

DISCARD_OBJS = $(patsubst src/exam/discard/%.java,class/exam/discard/%.class, $(wildcard src/exam/discard/*.java))
discard_demo:${DISCARD_OBJS}


CLASS_PATH= ${NETTY_HOME}netty-all-4.1.37.Final.jar:./src/:./class/

CLASS_PATH_CGYWIN := (`cygpath --path --windows "${CLASS_PATH}`) 

	
JC = javac



echo:
	@echo ${ECHO_OBJS}
	@echo ${DISCARD_OBJS}
	

class/exam/echo/%.class:src/exam/echo/%.java
	@echo "$@:$<"
	export CLASSPATH=`cygpath --path --windows "${CLASS_PATH}"`;${JC}  $< -d ./class/;chmod 700 $@;

class/exam/discard/%.class:src/exam/discard/%.java
	@echo "$@:$<"
	export CLASSPATH=`cygpath --path --windows "${CLASS_PATH}"`;${JC}  $< -d ./class/;chmod 700 $@;

clean:
	rm -f ./class/exam/echo/*.class
	rm -f ./class/exam/discard/*.class

run_s_echo:
	export CLASSPATH=`cygpath --path --windows "${CLASS_PATH}"`;	java exam.echo.EchoServer& 
run_s_discard:
	export CLASSPATH=`cygpath --path --windows "${CLASS_PATH}"`; 	java exam.discard.DiscardServer& 
run_c_echo:
	export CLASSPATH=`cygpath --path --windows "${CLASS_PATH}"`;java exam.echo.EchoClient 
run_c_discard:
	export CLASSPATH=`cygpath --path --windows "${CLASS_PATH}"`;java exam.discard.DiscardClient 

stop:
	kill `ps -ef|grep java |awk '{print $$2}'`



OBJS = $(patsubst %.java,%.class, $(wildcard *.java))



all:${OBJS}

SOURCE_PATH = \
	--source-path ./

CLASS_PATH= \
	-classpath ${HOME}/CODE/java/netty/netty-4.1.37.Final/jar/all-in-one/netty-all-4.1.37.Final.jar:./ 
	

JFLAGS = -g ${CLASS_PATH}  ${SOURCE_PATH}

JC = javac


%.class:%.java
	${JC} ${JFLAGS} $< -d .


clean:
	rm -f *.class

run:
	java ${CLASS_PATH}  EchoServer& 
	java ${CLASS_PATH}  EchoClient 

stop:
	killall java

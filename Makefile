COMPONENT=RoboHomeBaseAppC

TINYOS_ROOT_DIR?=../..
include $(TINYOS_ROOT_DIR)/Makefile.include

BUILD_EXTRA_DEPS += MoteStatus.class
CLEAN_EXTRA = *.class MoteStatusMsg.java


MoteStatus.class: $(wildcard *.java) MoteStatusMsg.java
	javac -target 1.4 -source 1.4 *.java


MoteStatusMsg.java:
	mig java -target=null $(CFLAGS) -java-classname=MoteStatusMsg MoteStatus.h mote_status_msg -o $@

CFLAGS += -I$(TOSDIR)/lib/T2Hack


include $(MAKERULES)


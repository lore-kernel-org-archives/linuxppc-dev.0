From: linuxppcdev@qbjnet.com
Date: 24 Aug 2004 13:30:26 -0000
Message-ID: <20040824133026.8287.qmail@kunk.qbjnet.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: IBM J2RE 1.4.2 weirdness?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know if this works on any PPC platform? On a debian sarge
system w/ 2.6.8 kernel on a 603ev I get:

debian:~$ /opt/IBMJava2-ppc-142/jre/bin/java OT40.jar
JVMDG218: JVM is not fully initialized - will not do dump processing.
Aborted

On a debian sarge system with a 2.4.27 kernel and a 400 mhz G3 I get:

~$ /opt/IBMJava2-ppc-142/jre/bin/java OT40.jar
JVMDG217: Dump Handler is Processing a Signal - Please Wait.
JVMDG303: JVM Requesting Java core file
JVMDG304: Java core file written to
 /home/bob/javacore.20040823.232137.1103.txt
JVMDG215: Dump Handler has Processed Exception Signal 4.
Illegal instruction

Of course the very same version of the jre for intel on an i386 sarge system
works fine as does OSX.

Is the IBM jre only for POWER 4 or something? I couldn't get the earlier
IBM 1.4.x jre's to work either.

OT40.jar is ourTunes:
http://ot.f00f.com/

Bob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

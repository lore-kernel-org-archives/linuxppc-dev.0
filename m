From: linuxppcdev@qbjnet.com
Date: 26 Aug 2004 18:57:26 -0000
Message-ID: <20040826185726.23331.qmail@kunk.qbjnet.com>
Subject: (fwd) Re: IBM J2RE 1.4.2 weirdness?
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Sven Luther Wrote:

> Disable the JIT and it should work. I had the same problem on a 600MHz
> 75xCxe or whatever it is called, because the JIT didn't recognize the
> CPU and thus died.

$ export JAVA_COMPILER=NONE
$ /opt/IBMJava2-ppc-142/jre/bin/java OT40.jar

Thanks, it WORKS!

Now I wonder what the libjit.so is looking for? According to Klaus Halfmann
it works on his clamshell ibook with 2.4.22 WITHOUT the jit disabled....

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

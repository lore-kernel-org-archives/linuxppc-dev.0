From: linuxppcdev@qbjnet.com
Date: 27 Aug 2004 04:22:18 -0000
Message-ID: <20040827042218.30743.qmail@kunk.qbjnet.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: (fwd) Re: IBM J2RE 1.4.2 weirdness?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marc Said:
> > User Sven Luther Wrote:
> > > Disable the JIT and it should work. I had the same problem on a 600MHz
> > > 75xCxe or whatever it is called, because the JIT didn't recognize the
> > > CPU and thus died.
> >
> > $ export JAVA_COMPILER=3DNONE
> > $ /opt/IBMJava2-ppc-142/jre/bin/java OT40.jar
>
> did you tried JITC_PROCESSOR_TYPE=6 ?
>
> Marc

Oh man, that was the MAGIC SWITCH! Now it even runs java 1.4 under Opera
(Opera doesn't use the plugin which the IBM JRE doesn't provide anyway).

Finally, a browser that works with a seemingly stable version of Java.
Too bad mozilla and firefox don't seem to be able to do java that way.

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

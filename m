From: marvin24@gmx.de
To: linuxppcdev@qbjnet.com
Subject: Re: IBM J2RE 1.4.2 weirdness?
Date: Thu, 26 Aug 2004 21:54:44 +0200
References: <20040826185726.23331.qmail@kunk.qbjnet.com>
In-Reply-To: <20040826185726.23331.qmail@kunk.qbjnet.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200408262154.44518.marvin24@gmx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Le Donnerstag 26 August 2004 20:57, vous avez écrit :
> User Sven Luther Wrote:
> > Disable the JIT and it should work. I had the same problem on a 600MHz
> > 75xCxe or whatever it is called, because the JIT didn't recognize the
> > CPU and thus died.
>
> $ export JAVA_COMPILER=NONE
> $ /opt/IBMJava2-ppc-142/jre/bin/java OT40.jar

did you tried JITC_PROCESSOR_TYPE=6 ?

Marc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

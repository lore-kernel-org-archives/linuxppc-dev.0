From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <v03110701b5a1e95b45a4@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 24 Jul 2000 08:44:33 -0400
Subject: Kaffe from cvs and some patches
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I built kaffe cvs using the cvs version of libffi and basicly it compiles
but does not really run any truly multi-threadsed apps (see
test/regressions/ThreadLocalTest.java for instance).

So I threw out libffi and threw back in my old sysdepCallMethod routine I
wrote for ppc back when kaffe first came out,  added a stack alignment
constraint to 16 to the jthreads code, and a few other very minor build
changes to get it to build with complete shared libs.

Kaffe now successfully runs the Cafeinemark 3 benchmark.

I anyone want these changes, please let me know.  I can't commit these
changes to kaffe since I am contaminated by seeing the JDK, however these
chnages all all ppc kaffe specific and have nothing whatsoever to do with
the jdk.

If anyone out there is helping kaffe, and wants my changes, please let me know.

Thanks,

Kevin

--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

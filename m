Message-ID: <01BFFA2B.F8827460.green@cygnus.com>
From: Anthony Green <green@cygnus.com>
Reply-To: "green@cygnus.com" <green@cygnus.com>
To: "'khendricks@ivey.uwo.ca'" <khendricks@ivey.uwo.ca>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Kaffe from cvs and some patches 
Date: Sun, 30 Jul 2000 13:40:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin wrote:
> I built kaffe cvs using the cvs version of libffi and basicly it compiles
but
> does not really run any truly multi-threadsed apps
> (see test/regressions/ThreadLocalTest.java for instance).

libffi itself is thread safe.  I suspect that Kaffe is using it incorrectly.
 Do you (or anyone else) know what the problem is?

AG


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

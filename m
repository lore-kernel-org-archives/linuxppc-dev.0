Message-ID: <3736E2EE.4C26B58B@fi.infn.it>
Date: Mon, 10 May 1999 15:45:18 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: MVME2431: how to use vme?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
after many problems (thanks to G.Paubert that gave the right patch for
the kernel and D. De Ridder for the many halps on setup) I have a
running system on a MVME2431.

I can also load the universe module without problems (at least it gave
me the message: Universe VME bridge #1 found at bus=0, dev=13 that seems
OK).

Now the problem is to test VME (to be precise the real problem is that
this is my first experience with VME, so have no idea from where to
start).
I read the README.universe in the kernel source, and I tried also to use
the program vmetest.c that I found in the same directory of the kernel
patches.

The problem is that that program cannot compile, it start with an error:
testvme.c:43:  'VME_attr' undeclared ....
and then gave a lot of other errors. I suppose that this depends on some
version mismatch (I'm using kernel 2.2.6, with related patch). 

Because this is not clear to me what I have to do to access another
board (the only one that I have use some fixed address memory location
in the VME bus, and no dma). I tried to look the testvme.c code but it
use some device (like /dev/cm_mem20) that I don't have on the system and
I cannot uned

Could someone send me some other test programs, just to try to
understand the right procedure, or also give me some directions for a
good starting point?

Thank you in advance for the further help, and thanks again for the
previous one.

Bye

PS. Just  another little question, but about the system setup. I used
linuxPPC pre5 rpms, installing them by hand with rpm, up to now (after
some modification to inittab, fstab and rc.sysinit) I have a working
system; my only concern is that I can telnet to other machines (also DNS
works), but when I try to telnet to the board I get:
Trying 192.84.146.131...
Connected to vmesez1.fi.infn.it.
Escape character is '^]'.
telnetd: All network ports in use.
Connection closed by foreign host.
and the same when I do the tlent from the board itself to localhost.
It's seems that it cannot allocate new port. Up to now I do not
understand from where came the problem (inetd.conf and all the tcp
wrapper files seems OK).
Thanks again
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

To: linuxppc-embedded@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Low memory problems in 8xx Linux
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 31 Jan 2000 16:02:01 +0100
Message-ID: <kfy3drel1xy.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

is anybody else experiencing severe problems when free memory gets low
in Linux? And I'm not talking about _out of memory_, just simply low
on RAM...

Even with 96 MB swap on ATA flash, and 26MB of memory in the cache
(ie not really in use), as soon as free pages hit the minimum limit
the system will lock solid. This happens before any swap is starting
to get used, and afterwards the system wont even answer to ping.

At some occasions all processes (including init) will simply crash
with an illegal instruction or segfault, and the kernel seems to
live on.

This happens with kernels 2.2.5, 2.2.10, 2.2.12, 2.2.13, 2.2.14 and
2.2.15pre5 + Rik's boobytrap2 patch, on MBX, ADS, FADS, RPX Lite and
custom boards. (2.2.12 and earlier based on Dan Malek's 2.2.5, 2.2.13
and later based on his 2.2.13).

So, has anyone else experienced problems like this?

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200307071146.h67BkHj02191@kruuna.Helsinki.FI>
Subject: Kernel 2.4.21-ben2 does not boot on Rev 1 Xserve
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 7 Jul 2003 14:46:17 +0300 (EEST)
Reply-To: Atro.Tossavainen@Helsinki.FI
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I tried to upgrade the kernel on our Xserve to 2.4.21-ben2 which I just
downloaded from source.mvista.com with rsync.

The bootup messages scroll by quite quickly, but if I'm not mistaken,
the IDE driver announced the following:

PDC20270: neither IDE port enabled (BIOS)

and fails to boot because it can't see the disks.

The computer works fine with 2.4.20-ben1, which I seem to have installed
on February 18 this year.

--
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / >

File attachments NOT welcome unless agreed to beforehand.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

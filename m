Message-Id: <v04003a04b3e7e12ecd82@[216.81.20.86]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 24 Aug 1999 00:59:31 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Performa 5200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello PPC folk,

I recently obtained for myself up a Performa 5200, and I've been playing
with trying to hack linux into shape on it. (I'm usually a Mac68k guy)

I compiled a kernel from a stock 2.2.10 tree that I have laying around
(from ftp.kernel.org, most every config option turned off, booting with
BootX) and, after sprinkling around a bit of debug code, found that it
makes it past the prom.c code where it draws the "Welcome to linux
[blahblah] booting...", but doesn't make it to start_kernel after that.

I'm not particularily fluent in PPC ASM, so head.S makes fairly opaque
reading for me. I'm wondering if someone might have some pointers to where
this would likely be dying, so I have good a place to start?

Thanks.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Mime-Version: 1.0
Message-Id: <p04330102b69d64c82c08@[24.163.36.97]>
Date: Wed, 31 Jan 2001 02:04:56 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: continuing XF402 (atimisc) problems
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been over this on the -user list and the YDL list, and cc-ed Ani
a few times with it (no response). No one seems to have a clue as to
the cause of the problem, which is described concisely at:

<http://lists.linuxppc.org/listarcs/linuxppc-user/200101/msg00672.html>

(more detail available if necessary)

This is on a 6500 (on-board RageII) with a RagePro PCI card. I have
tried rolling my own XF402 build, with Ani's driver updates, and get
the exact same XFree log result. I've also tried several of kfukui's
402 rpms, including use of his "old drivers," again with exactly the
same result.

I've also done this with an old mix of LinuxPPC 1999 and YDL 1.2.1
installations, and a clean LinuxPPC Q4 install. I've also tried it
with kernels 2.2.17, 2.2.18, and 2.4.1. Again all the same result.

I can run with fbdev no problem. I've also had no problem installing
XF402 on 2 9500-class machines, so I believe my technique is OK. I'm
pretty darn sure at this point that my Xfree86Config file is correct
(correct driver, correct Bus ID).

The errors (unresolved symbols) do not seem like a program bug to me,
more like a linker issue or a library issue? (I'm a bit out of my
element here)

If anyone can help me... well, you know the part about THANKS.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

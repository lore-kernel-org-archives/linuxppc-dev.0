Message-Id: <200003090638.HAA00445@piglet.grunz.lu>
Date: Thu, 9 Mar 2000 07:38:12 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: 2.3.48 hang on starting init?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list,

Yet another quirk I've found with 2.3:

Sometimes, when booting, the kernel would hang just after freeing init
kernel memory, before starting init.

I've booted 4-5 times now without a problem, but it seems to happen
every time when the root partition is not marked as clean (i.e. after a
crash).

It seems to be related either to init not starting, or to the kernel
not being able to deal with the non-clean root partition. The problem
appears way before fsck gets a chance at the partition.

Anybody seen something similar? Any idea what I should look at?

Hmmm, my init is 2.74 from my old R4 install; maybe I should give R5 or
2000 a try?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

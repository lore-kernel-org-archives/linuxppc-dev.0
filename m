Message-Id: <200008100610.IAA01208@piglet.grunz.lu>
Date: Thu, 10 Aug 2000 08:10:39 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Hidden file in linux-pmac-devel @ linuxcare.com.au
To: Paul Mackerras <paulus@linuxcare.com>
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

There's a hidden link somewhere in your devel tree pointing to something
not existing within that tree:

...
diff: linux/arch/i386/kernel/.#pci-pc.c: No such file or directory
...

[mlan@piglet /mnt/r4/usr/src]$ ll linux/arch/i386/kernel/.#pci-pc.c
lrwxrwxrwx   1 mlan     users          44 Aug  9 19:39 linux/arch/i386/kernel/.#pci-pc.c -> paulus@argo.linuxcare.com.au.28496:961157532

If it doesn't serve some specific purpose, you may want to remove it...

Thanks


Michel

PS The problems I reported earlier in fs/ext2 are in fact fixed in rsync
right now, however although I had the non-fixed versions locally, they
were not sync'ed to the fixed ones... timestamp problem??

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200003160332.WAA15626@shell.faradic.net>
Date: Wed, 15 Mar 2000 17:32:27 EST
From: jingai <jingai@floatingpenguins.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel 2.3.x -- BK vs. Paul's tree
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Okay, I've just read thru quite a few threads on this topic in the list
archives, and am still quite confused.  Someone mentioned that Paul's tree
is the tree to get for PowerMacs, and BK is for PReP/CHRP; however, I see
everyone mentioning that BK is far more up-to-date than Paul's tree.

1)  Is this true?
2)  If so, should I use BK even though I've got a PowerMac (UMAX S900)?

The biggest reason I ask is because I cannot get Paul's 2.3.51 to work
right on my machine.  After disabling "Initial BootX console" I finally got
it to boot -- somewhat.  Now it makes it just a very short way into the
boot process and panics (something something something AltiVec something --
can't remember exactly).  I have tried it with AltiVec support both enabled
and disabled.  (I have a Sonnet G3/300 upgrade card, BTW).

Has anyone else encountered this problem?

Also, when is Paul going to add the brightness adjustment for the ATI
RageProLT chipset (LI_CHIP_ID) in drivers/video/atyfb.c so I don't have to
do it manually everytime I rsync :)  (Not that it's difficult, I'm just
being picky :)

Anyway, thanks in advance for any help,
Jonathan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

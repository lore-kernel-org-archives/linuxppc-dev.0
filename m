Date: Thu, 31 Dec 1998 14:52:44 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: linux-pmac@samba.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: 2.2.0-pre2
Message-ID: <Pine.LNX.4.05.9812311424090.974-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,
  Linux 2.2.0-pre2 is out, and compiles outta the box.  There is of course
a diff against that of things in vger/should be in vger :) at:

http://dobbstown.yeti.edu/vger-linus7.diff

This has (for Corts benefit if he feels like sending more to linus :)):

arch/ppc/defconfig,pmac_config  - tulip and dex4x5 as modules,
CONFIG_SERIAL off (pmac doesn't need it and it oopes, and pmac makes up a
very large majority (at least keep the 1st part tho, that is of use to
all)

CONFIG_ADBMOUSE now lets you boot with adb_buttons=2,XX,XX and do right
option/control+click for buttons two+three (as button emu used to be, from
Franz Sirl)

include/asm-ppc/dma.h - #define dma_isa_is_buggy or whatever, from Geert

drivers/net/Makefile,Config.in - Allow bmac/mace modules

drivers/net/mace.c - spinlocks, stability fixes

drivers/scsi/sd.c - stability fixes for mac53c94 (at least, from Paul a
while ago)

chrp/prep/mbx_defconfig, say N to all sorts of new options (mbx was done
right now, d'oh!)

video updates are for normal users of course..

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

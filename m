Date: Thu, 30 Sep 1999 13:45:14 -0700
From: Matt Porter <mporter@eng.mcd.mot.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: BUGboot 0.2 - Boot Linux from flash on Moto boards
Message-ID: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've released my bugboot package at 0.2 since it doesn't look like PPCBUG
will have residual data support in the RB facility any time soon.  This
adds a horrible kludge to copy  a residual data tree included in the
flash image.

What is it?

It's a simple tool and bootloader that creates a flashable image from a
Linux kernel/initrd and a dump of a residual data tree.  This image is
flashed onto any Motorola PowerPlus board 4/8/16 MB flash bank and then
Linux is booted from the flash.  This works on 
MVME23xx/24xx/26xx/27xx/36xx/46xx, MCPx750, and MTX variants.

Available at http://members.home.net/mmporter/linux/

-- 
Matt Porter                                   Motorola Computer Group
mporter@mcg.mot.com                           CIBU Linux Support

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

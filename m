Date: Fri, 12 Nov 1999 16:45:38 -0700
From: Matt Porter <mmporter@home.com>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: BUGboot 0.3 - Boot Linux from flash on Moto boards
Message-ID: <19991112164538.C9169@cx258813-a.chnd1.az.home.com>
References: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com>; from mporter@eng.mcd.mot.com on Thu, Sep 30, 1999 at 01:45:14PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've released a new 0.3 version of BUGboot to address some bugs where it
just didn't work with certain sized kernel and residual data images. Also,
the new version can build cross build flashable images as well now from
both big and little endian machines.  Thanks to Christian Zankel for a
patch that helped me locate some of the problems with 0.2.

I've tested builds on ppc and i386 and tested so far on MVME2300SC,
MVME2400, and MTX+ targets.

Available at http://members.home.net/mmporter/linux/

If you are wondering what it is:

  It's a simple tool and bootloader that creates a flashable image from a
  Linux kernel/initrd and a dump of a residual data tree.  This image is
  flashed onto any Motorola PowerPlus board 4/8/16 MB flash bank and then
  Linux is booted from the flash.  This works on 
  MVME23xx/24xx/26xx/27xx/36xx/46xx, MCPx750, and MTX variants.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

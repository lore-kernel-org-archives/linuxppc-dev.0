Return-Path: <tr@gtnw.de>
Received: from snatch.gtnw.de (gtnw.de [217.160.108.65])
	by ozlabs.org (Postfix) with ESMTP id E924E2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2004 12:23:46 +1100 (EST)
From: Timo Reimerdes <tr@gtnw.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1101877409.5672.2.camel@gaston>
References: <1101877409.5672.2.camel@gaston>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 01:55:14 +0100
Message-Id: <1101948915.4972.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: fedora-ppc@lists.infradead.org, gentoo-ppc-user@gentoo.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-ppc <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #6
Reply-To: tr@gtnw.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok,

I mentioned those weird problems about the computer not falling asleep?
It keeps happening. I compiled a kernel with the config from Alexander
Wirt and tried alot of combinations. 

The logs really wont help a lot.
USB-Mouse plugged in/out wont change anything, AC plugged in/out wont
change anything, restarting X wont fix it. 

Is there a possibility that pbbuttonsd is somehow related to that
problem? I wonder. Might check that out later. 

This problem I must fix before I can call sleep working. It's really
annoying. 
Do you have any hint on "what needs to be running" or "needs to be set
to X" or anything I could look for?

There are two things I do get during boot:
_________________________________________________
Dec  2 01:41:38 localhost kernel: pmac_zilog: 0.6 (Benjamin
Herrenschmidt <benh@kernel.crashing.org>)
Dec  2 01:41:38 localhost kernel: pmac_zilog: Error registering serial
device, disabling pmac_zilog.
Dec  2 01:41:38 localhost kernel: pmac_zilog: Did another serial driver
already claim the minors?
Dec  2 01:41:38 localhost kernel: RAMDISK driver initialized: 16 RAM
disks of 8192K size 1024 blocksize
Dec  2 01:41:38 localhost kernel: divert: not allocating divert_blk for
non-ethernet device lo
Dec  2 01:41:38 localhost kernel: MacIO PCI driver attached to Intrepid
chipset
Dec  2 01:41:38 localhost kernel: input: Macintosh mouse button
emulation
.
.
.
_________________________________________________
Dec  2 01:41:38 localhost kernel: device-mapper: 4.1.0-ioctl
(2003-12-10) initialised: dm@uk.sistina.com
Dec  2 01:41:38 localhost kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Dec  2 01:41:38 localhost kernel: hdc: packet command error: status=0x51
{ DriveReady SeekComplete Error }
Dec  2 01:41:38 localhost kernel: hdc: packet command error: error=0x54
Dec  2 01:41:38 localhost kernel: ide: failed opcode was 100
Dec  2 01:41:38 localhost kernel: cdrom: open failed.
Dec  2 01:41:38 localhost kernel: device-mapper: : dm-linear: Device
lookup failed
Dec  2 01:41:38 localhost kernel:
Dec  2 01:41:38 localhost kernel: device-mapper: error adding target to
table
Dec  2 01:41:38 localhost kernel: device-mapper: : dm-linear: Device
lookup failed
Dec  2 01:41:38 localhost kernel:
Dec  2 01:41:38 localhost kernel: device-mapper: error adding target to
table
.
. (20 times ".... failed"
.
Dec  2 01:41:38 localhost kernel: device-mapper: error adding target to
table
.
.
.
________________________________________________________

other than that my boot looks really clean and without any more errors.

If you could give me some hints I would really appreciate that.

Greetings

Timo Reimerdes

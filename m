Message-ID: <39DABA39.37B03026@mvista.com>
Date: Wed, 04 Oct 2000 05:03:53 +0000
From: Scott Anderson <sanders@mvista.com>
MIME-Version: 1.0
To: jari.nguyen@smartstors.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mount RAMDISK directly on rom
References: <39D485A1.2785C0E4@serialsystem.com.sg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jari wrote:
> Is there anyone know how to let the uncompressed ramdisk image in the
> rom,
> and mount root system directly from it (read only)?

In general, I would add a driver that exposed your rom as a device and
then just tell your kernel that root is on your device.  I have
successfully used the MTD drivers to do exactly this in the past.  I'd
suggest poking around:
  http://www.linux-mtd.infradead.org/

    Scott Anderson
    scott_anderson@mvista.com	MontaVista Software Inc.
    (408)328-9214		490 Potrero Ave.
    http://www.mvista.com	Sunnyvale, CA  94086

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <397E0874.564A99B6@mvista.com>
Date: Tue, 25 Jul 2000 21:36:52 +0000
From: Scott Anderson <sanders@mvista.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: flash filesystem
References: <4.3.2.7.0.20000824132843.00b1f9a0@10.0.0.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike Coy wrote:
> The best that I can come up with is that the flash is probably mapped into
> memory somewhere, and maybe I could fool the ramdisk code into reading a
> pre-existant ramdisk at a given address.  This didn't appear to be too
> trivial at my first browse through the code, though.
> What is the right way to get at data in flash?

I used the MTD code to accomplish the same thing.  I have a compressed
ext2 filesystem image sitting in FLASH and pass the MTD slram driver
the beginning and ending address and it exposes the FLASH as /dev/mtd0.
To make sure we're on the same page, I'm talking about a read-only
filesystem.

Check out http://www.linux-mtd.infradead.org/ to get started with the
MTD layer.  I'm under the impression that MTD has gone into the 2.4
kernel so it should become "the" way of doing this.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               490 Potrero Ave.
    http://www.mvista.com       Sunnyvale, CA  94086

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

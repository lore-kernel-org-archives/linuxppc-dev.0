Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE001.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 8A733DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Dec 2008 05:16:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: virtex uImage and serial ports
Date: Tue, 30 Dec 2008 11:16:34 -0700
In-Reply-To: <1230158881.82162837@192.168.1.35>
References: <1230158881.82162837@192.168.1.35>
From: John Linn <John.Linn@xilinx.com>
To: "Joshua Lamorie" <jpl@xiphos.ca>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081230181636.49A821BA0065@mail222-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Joshua,

Have you looked at our wiki site at http://xilinx.wikidot.com as we
quite a bit of information there.

The ML405 board is a V2Pro chip so it should be pretty close to what you
want using the default kernel config for virtex4.

I haven't tested the console at 115,200 as I use it at 9600.  Shouldn't
be a problem, but may not hurt to stay at 9600 to get it working.

There are pages on the wiki about using u-boot with the kernel also as
it sounds like that's what you're doing.

Thanks,
John


> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Joshua Lamorie
> Sent: Wednesday, December 24, 2008 3:48 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: virtex uImage and serial ports
> =

> Gidday there,
> =

> I am trying to get 2.6.27(ish) running on my custom Virtex-II Pro
platform (I call it Q5).  I already
> have many years of running 2.4.26 and booting from u-boot.
> =

> The problem is getting the console running.  I have a device tree blob
built and loaded into memory,
> and by peeking at __log_buf I can see that it is reading this okay
(i.e. it is correctly finding my
> interrupt controller).  However, by the time it goes to mount the
ramdisk as root, it complains that
> there is no console.
> =

> I'm fairly certain /chosen has stdout pointing to the correct UART,
and the console arguments are
> ttyS0,115200.
> =

> In looking through the code however, I cannot figure out how the
uImage code actually initializes the
> serial-ports for the XILINX_VIRTEX_GENERIC_BOARD.  As I understand it,
the only place where
> serial_console_init is called, is within platform_init, and this isn't
called for uImage.
> =

> So, three questions.
> =

> 1) How is the serial driver supposed to know where the platforms
serial ports are?
> =

> 2) If I wanted to scrap u-boot and just copy kernel/ramdisk/dtb to
memory, which kernel make target
> should I use?  dtbImage, simpleImage?
> =

> 3) What is the best, most modern image to build that should be used by
u-boot?
> =

> Thanks in advance
> =

> Joshua
> =

> p.s. I've been trying with kernel.org mainline, xilinx git and denx
ELDK xenomai (2.6.24).  U-boot is
> built from latest git source.  DTS file built from XPS 9.1i with
latest service packs, and turned
> into DTB with latest dtc source from git.
> =

> =

> --
> Xiphos Technologies
> (514) 847-9474 x227
> (514) 848-9644 fax
> =

> www.xiphos.com
> _______________________________________________
> The information transmitted is intended only for the
> person or entity to which it is addressed and may contain
> confidential and/or privileged material.  If you have
> received this in error, please contact the sender and delete
> this communication and any copy immediately. Thank you.
> =

> =

> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D9CA3DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 03:24:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: xilinx linux on a XUPV2P
Date: Thu, 8 May 2008 10:24:19 -0700
In-reply-to: <48230682.8090000@delta.uni-dortmund.de>
References: <48230682.8090000@delta.uni-dortmund.de>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Dr. Peter Hartmann" <hartmann@delta.uni-dortmund.de>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080508172430.BC58537006C@mail193-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Sounds like it's not finding the console.
If you're using the uartlite, you need to specify console=3DttyUL0 on =
the
kernel command line.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Dr. Peter
Hartmann
> Sent: Thursday, May 08, 2008 6:56 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: xilinx linux on a XUPV2P
>=20
> Hello everybody,
>=20
> I am trying to get the latest Kernel (2.6.25-rc9) from git.xilinx.com
running on
> a XUPV2P board. I generated the hardware using JH Kelms step by step
list,
> skipping points 6-8 and replacing point 9 by a more modern version of
doing
> this. When I boot the system.ace from the CF card, the bootloader
talks to me
> over the RS232, but as soon as it tries to boot the kernel it hangs
up.
> I had 2.6.18-rc3 which I got from somebody else running this way. The
reason I
> intend to change is the UARTLITE driver, which seems to be included in
the
> latest kernel tree.
> I use Platform Studio 9.1.02i which I also used for the 2.6.18 Kernel.
> Has anybody yet got this to work out with 9.1.02i ??
> Would it be possible for somebody to give a dummy like me the steps
you took to
> get it working on your board? I'm really lost here. Thanks!
>=20
>=20
> Thanks in advance!

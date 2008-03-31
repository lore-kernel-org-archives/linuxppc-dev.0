Return-Path: <John.Linn@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 72493DDFF5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 00:22:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: U-boot + Linux 2.6 + Avnet FX12 MM (based on ML403 config)
Date: Mon, 31 Mar 2008 08:22:16 -0600
In-Reply-To: <16384525.post@talk.nabble.com>
References: <10201070.post@talk.nabble.com> <16384525.post@talk.nabble.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080331142239.B4F3410057@mail50-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mirek,

Our Git server from Xilinx, git.xilinx.com, has a kernel that is 2.6.24
based if this helps.=20

All of my testing for Virtex 4 is on the ML405 board which is an FX20
device rather than an FX12, but the kernel configuration is pretty much
compatible.

Thanks,
John

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Mirek23
Sent: Sunday, March 30, 2008 11:21 AM
To: linuxppc-embedded@ozlabs.org
Subject: Re: U-boot + Linux 2.6 + Avnet FX12 MM (based on ML403 config)


Hi Guillaume,

I was facing the same problem with my Avent (virtex 4 FX12) evaluation
board. Originally I have built successfully u-boot 1.2.0  and linux
2.6.21
but I was not able to boot kernel 2.6.21 from u-boot 1.2.0. Kernel
2.6.22
(uImage) onwards can be booted with u-boot 1.2 and higher. Currently I
use
u-boot 1.2.0 and kernel 2.6.23 without any problems. My recommendation
is to
use at least the kernel version 2.6.22 otherwise you will have kernel
panic
problem.

Best Regards

Mirek


Guillaume Berthelom wrote:
>=20
> Hi,
>=20
> I'm trying to port Linux 2.6 on Avnet FX12 MM board with U-Boot and
the
> help of xilinx ML403 config.
>=20
> I have generate my costum xparameters.h file with EDK 8.2i.
> I use ELDK 4.1 and Linux 2.6.20.x.
> I have modified ml403.h u-boot's config file to adapt it for my board
and
> I have no problem to boot u-boot.
> I use the right board_info structure from <asm/ppcboot.h> and not the
one
> in xilinx_ml403.h.
>=20
> When I load the zImage directly with xilinx xmd debugger, the kernel
start
> without problem (if I don't have KGDB or SERIAL_TEXT_DEBUG option in
my
> kernel config). But when I try to load the uImage with u-boot, the
kernel
> start but crach befor I can see something on output.
>=20
> The kernel start because I debug it and the platform_init is ok,
> setup_arch too and it crach after ppc4xx_setup_arch at
printk(KERN_INFO
> "Xilinx ML403 Reference System (Virtex-4 FX)\n") line  when the kernel
> access in printk.c.
>=20
> I suppose the serial init have problem but I have no idea what is the
> cause of the problem. I use the opb_uart16550 IP in my Xilinx design
and
> the associat drivers in u-boot and linux.
>=20
> Thanks,
> Guillaume Berthelom
>=20
>=20

--=20
View this message in context:
http://www.nabble.com/U-boot-%2B-Linux-2.6-%2B-Avnet-FX12-MM-%28based-on
-ML403-config%29-tp10201070p16384525.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

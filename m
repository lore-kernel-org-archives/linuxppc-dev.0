Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 477C8DE0D2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 04:56:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Using GPIO
Date: Thu, 15 May 2008 11:56:35 -0700
In-reply-to: <20080515183910.6B40A75007E@mail106-va3.bigfish.com>
References: <02f401c8b6a9$b1e062e0$ad289e86@LPSC0173W>
	<20080515183910.6B40A75007E@mail106-va3.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Bonesio" <john.bonesio@xilinx.com>,
	"Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>, <linuxppc-dev@ozlabs.org>
Message-Id: <20080515185637.587AF43004B@mail186-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



I don't think the GPIO driver has device tree bindings yet in the driver
for ARCH=3Dpowerpc.

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of John
Bonesio
> Sent: Thursday, May 15, 2008 11:39 AM
> To: Guillaume Dargaud; linuxppc-dev@ozlabs.org
> Subject: RE: Using GPIO
>=20
>=20
> Hi Guillaume,
>=20
> If you're using arch/powerpc, my understanding is that
> CONFIG_XILINX_GPIO needs to be enabled as well as having the right
info
> in the dts file.
>=20
> Right now I'll have to defer to others to tell you what's needed in
the
> dts file.
>=20
> If you're using arch/ppc, I believe you just need CONFIG_XILINX_GPIO
> enabled.
>=20
> When the system boots up, you see a message on the console when the
GPIO
> driver initializes.
>=20
> This is not exactly a tutorial. Hopefully this still helps,
>=20
> - John
>=20
> -----Original Message-----
> From: linuxppc-dev-bounces+john.bonesio=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+john.bonesio=3Dxilinx.com@ozlabs.org] On
> Behalf Of Guillaume Dargaud
> Sent: Thursday, May 15, 2008 9:35 AM
> To: linuxppc-dev@ozlabs.org
> Subject: Using GPIO
>=20
> Hello all,
> I'm trying to use the Xilinx GPIO from a user program.
> Since I haven't managed to compile their example (simon.c is given
> without a
> makefile), I wanted to try using /dev/gpio...
>=20
> So I added
> /dev/gpio0  c  666  0  0  10  185 -  -  -
> to device_table.txt when I generated my root filesystem with
buildroot,
> but
> apparently this leads nowhere as it's not visible in /proc/devices.
>=20
> Is there some example or tutorial on how to use CONFIG_XILINX_GPIO ?
> Either
> as a device or as API calls...
> --
> Guillaume Dargaud
> http://www.gdargaud.net/
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
> This email and any attachments are intended for the sole use of the
named recipient(s) and contain(s)
> confidential information that may be proprietary, privileged or
copyrighted under applicable law. If
> you are not the intended recipient, do not read, copy, or forward this
email message or any
> attachments. Delete this email message and any attachments
immediately.
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be=
 proprietary, privileged or copyrighted under applicable law. If you are=
 not the intended recipient, do not read, copy, or forward this email=
 message or any attachments. Delete this email message and any attachments=
 immediately.

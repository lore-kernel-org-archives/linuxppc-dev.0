Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C297DDDED2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 02:03:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: a question for linux framebuffer driver
Date: Mon, 11 Jun 2007 09:03:11 -0700
In-Reply-To: <1316548361.5052161181391690811.JavaMail.coremail@bj163app129.163.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "silicom" <silicom@163.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070611160313.B1A36DA8056@mail207-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The kernel has to be informed of the device itself using =
platform_device_register.
I believe in the kernel you have you'll have to add code to do this, and =

/arch/ppc/platforms/4xx/virtex.c is a reasonable place.=20

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
> labs.org] On Behalf Of silicom
> Sent: Saturday, June 09, 2007 5:22 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: a question for linux framebuffer driver
>=20
> Hello,
> Now I'm porting framebuffer driver for ml403 in linux=20
> 2.6.171, but I find after registering the driver using=20
> driver_register function in xilinxfb_int, the=20
> xilinxfb_drv_probe function has not been called, so=20
> framebuffer not registered yet, no devices founded(but I have=20
> connected the monitor). I want to know when will=20
> xilinxfb_drv_probe be called?
>=20
> =20
> =20
> =20
>=20
>=20
> ________________________________
>=20
> 150 =CD=F2 =C8=CB =CD=AC =CA=B1 =D4=DA =CD=E6 =B5=C4 =CD=F8 =
=D3=CE=A3=AC=C4=E3 =B2=BB =CA=D4 =CA=D4 =C2=F0 =A3=BF=20
> <http://event.mail.163.com/chanel/xyq.htm?from=3D163_NO1>=20
>=20

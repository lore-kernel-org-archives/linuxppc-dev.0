Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3CB7BDDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 04:37:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel Debug on Virtex4-FX
Date: Thu, 6 Sep 2007 11:37:27 -0700
In-Reply-To: <1189103551.6185.66.camel@PisteOff>
References: <1189103551.6185.66.camel@PisteOff>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070906183729.61833E20054@mail205-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It believe it should work fine:
You just need to set breakpoints in the kernel proper=20
using virtual memory addresses.
I've never actually tried tracing through the enabling of the MMU,
however...

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of Robert Woodworth
> Sent: Thursday, September 06, 2007 11:33 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Kernel Debug on Virtex4-FX
>=20
> Is it possible to debug the kernel via Xilinx JTAG Platform USB cable?
>=20
> If so, how?
> I can debug through the embedded-config.c and boot loader,=20
> but once the
> kernel boots, (VM on) I cannot debug anymore. =20
>=20
>=20
> Or do I have to use kgdb through serial?=20
>=20
>=20
>=20
>=20
> Rob.
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

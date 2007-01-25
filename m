Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id BFB1ADE039
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 14:35:19 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0P3ZI4U014988 for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 20:35:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0P3ZFhe012164
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 21:35:17 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8260 I2C Problem
Date: Thu, 25 Jan 2007 11:36:23 +0800
Message-ID: <989B956029373F45A0B8AF029708189008734F@zch01exm26.fsl.freescale.net>
In-Reply-To: <78452.12201.qm@web53101.mail.yahoo.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "jimmy liu" <jimmyzhmliu@yahoo.com>,
	"embedded linuxppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> jimmy liu
> Sent: Thursday, January 25, 2007 11:22 AM
> To: embedded linuxppc
> Subject: MPC8260 I2C Problem
>=20
> I download the linux kernel 2.6.19 from
> ftp://ftp.denx.de/pub/linux/ site.
>=20
> When I add mpc8260 I2C driver to Linux kernel 2.6.19,
> the init function looks like that
> static int __init fsl_i2c_init(void)
> {
> 	return driver_register(&fsl_i2c_driver);
> }
> I set the debug on, and found that the fsl_i2c_probe()
> function is never called, so there is not I2C device
> enabled, and the user space function
> open("/dev/i2c-0",O_RDWR) always return error. I set
> something wrong? Could somebody help me?

Do you have an fsl-i2c node in your device tree?

- Leo

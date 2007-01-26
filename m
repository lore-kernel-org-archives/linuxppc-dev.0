Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 58FBBDE00F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 16:49:00 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0Q5muD1025845 for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 22:48:56 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0Q5ms83011569
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 23:48:55 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8260 I2C Problem
Date: Fri, 26 Jan 2007 13:50:04 +0800
Message-ID: <989B956029373F45A0B8AF0297081890087468@zch01exm26.fsl.freescale.net>
In-Reply-To: <799271.50055.qm@web53111.mail.yahoo.com>
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

You are talking about the wrong i2c driver.  For 8260, you need a cpm
i2c driver, not the i2c-mpc driver.

- Leo

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> jimmy liu
> Sent: Friday, January 26, 2007 1:06 AM
> To: embedded linuxppc
> Subject: RE: MPC8260 I2C Problem
>=20
> In the arch\ppc\syslib\pq2_devices.c, there has the
> device descriptions.
> Do I still need manually create the plateform bus
> tree?
>=20
> --- Li Yang-r58472 <LeoLi@freescale.com> wrote:
>=20
> > > -----Original Message-----
> > > From:
> >
> linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> > >
> >
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org]
> > On
> > Behalf Of
> > > jimmy liu
> > > Sent: Thursday, January 25, 2007 11:22 AM
> > > To: embedded linuxppc
> > > Subject: MPC8260 I2C Problem
> > >
> > > I download the linux kernel 2.6.19 from
> > > ftp://ftp.denx.de/pub/linux/ site.
> > >
> > > When I add mpc8260 I2C driver to Linux kernel
> > 2.6.19,
> > > the init function looks like that
> > > static int __init fsl_i2c_init(void)
> > > {
> > > 	return driver_register(&fsl_i2c_driver);
> > > }
> > > I set the debug on, and found that the
> > fsl_i2c_probe()
> > > function is never called, so there is not I2C
> > device
> > > enabled, and the user space function
> > > open("/dev/i2c-0",O_RDWR) always return error. I
> > set
> > > something wrong? Could somebody help me?
> >
> > Do you have an fsl-i2c node in your device tree?
> >
> > - Leo
> >
>=20
>=20
>=20
>=20
>
________________________________________________________________________
______
> ______
> Don't pick lemons.
> See all the new 2007 cars at Yahoo! Autos.
> http://autos.yahoo.com/new_cars.html
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

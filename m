Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6E2EF679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 20:48:52 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7OB107V008060 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 04:01:00 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7OAmmBi002201
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 05:48:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: I2C driver for SAA7121 on MPC855 and linux-2.4.25
Date: Thu, 24 Aug 2006 18:49:18 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC383@zch01exm20.fsl.freescale.net>
In-Reply-To: <84681EC46E2C6347953892915BA5DAB1038FE72F@SHAMLVEM01.e2k.ad.ge.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Xu, Li \(GE, Research\)" <li.xu@ge.com>, <linuxppc-embedded@ozlabs.org>
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
> Xu, Li (GE, Research)
> Sent: Thursday, August 24, 2006 4:02 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: I2C driver for SAA7121 on MPC855 and linux-2.4.25
>=20
> Hi,
>=20
> I am trying to setup i2c driver for saa7121 on my mpc855 based board
> normally the address for saa7121 is 0x88, but when I enable i2c bus
> scan, the driver detect it's address is 0x34, so I just stick to 0x34.

Is it the only device on i2c bus?=20
>=20
> Anyway, I can write to saa7121via i2c bus successfully, but I can't
enable
> color bar, so I don't know whether the driver is working properly or
not?

Are you sure you are operating on the correct device?  What operation
can you do successfully on the device?  Can you read from the i2c bus?
>=20
> BTW, I setup I2C driver for SAA7113 and it works fine.
>=20
> Tim

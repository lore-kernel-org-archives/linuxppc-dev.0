Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FE7ADE28D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 18:55:14 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3H8t8Lc004533
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 01:55:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3H8t624012198
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 03:55:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: A question about the 8250/16550 Driver
Date: Thu, 17 Apr 2008 16:55:04 +0800
Message-ID: <989B956029373F45A0B8AF02970818900200759C@zch01exm26.fsl.freescale.net>
In-Reply-To: <351993.9457.qm@web15901.mail.cnb.yahoo.com>
References: <351993.9457.qm@web15901.mail.cnb.yahoo.com>
From: "Li Yang" <LeoLi@freescale.com>
To: =?gb2312?B?0PEgwt4=?= <luoxu_gun@yahoo.com.cn>,
	"Linu PPC Mail list" <linuxppc-dev@ozlabs.org>
Cc: Wood Scott <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of =D0=F1 =C2=DE
> Sent: Thursday, April 17, 2008 3:32 PM
> To: Linu PPC Mail list
> Cc: Wood Scott
> Subject: A question about the 8250/16550 Driver
>=20
> Hello:
>     I have founded that the serial can't be initialized as=20
> the bootting process. My platform is MPC8313 and my kernel=20
> version is linux-2.6.23.9. I look though the source code and=20
> find that the MPC8313 driver is compatible with 8250/16550.=20
> The driver is in the \drivers\serial\8250.c
>=20
> In the function serial8250_isa_init_ports we should use the=20
> structer old_serial_port  but i can't find the definition for=20
> this struct. I can only find the following senrense in the=20
> head of this file=20

If you look into the function carefully enough, you can find that =
old_serial_port is optional and can be empty.  It seems to be some =
leftover to provide backward compatibility when the port structure =
changed.

- Leo

Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DAD39DDF37
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 18:31:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l638Ulc2018009
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Jul 2007 01:31:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l638UjBc001723
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Jul 2007 03:30:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Anyone using QE UART mode?
Date: Tue, 3 Jul 2007 16:32:42 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D83844@zch01exm26.fsl.freescale.net>
In-Reply-To: <8F798BFDA851B943B3A1B2510E9287850350A908@airmail.wirelessworld.airvananet.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Ying Lin" <ylin@airvana.com>, "Tabi Timur-B04825" <timur@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
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
Behalf
> Of Ying Lin
> Sent: Tuesday, July 03, 2007 12:02 AM
> To: Tabi Timur-B04825
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: Anyone using QE UART mode?
>=20
> OK, the missing piece (UART driver) I am looking for is not available
> yet.  I will seek alternative solutions (create a simple UART driver,
or
> just wait).

Which chip are you using?  There should be separate 16550 compatible
UART controller on MPC8360.  The driver is already there and working
pretty well.

- Leo

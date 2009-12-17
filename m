Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5606EB6F19
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 18:59:52 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBH7xmvV027976
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 00:59:48 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBH84CGB001452
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 02:04:13 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Thu, 17 Dec 2009 13:29:45 +0530
Message-ID: <0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>
In-Reply-To: <4B29DC2B.8090405@embedded-sol.com>
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>	<4B28CBC4.4010501@embedded-sol.com><0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>
	<4B29DC2B.8090405@embedded-sol.com>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org, Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From:=20
> linuxppc-dev-bounces+vivek.mahajan=3Dfreescale.com@lists.ozlabs.
> org=20
> [mailto:linuxppc-dev-bounces+vivek.mahajan=3Dfreescale.com@lists
> .ozlabs.org] On Behalf Of Felix Radensky
> Sent: Thursday, December 17, 2009 12:52 PM
> >
> > I just noticed a MSI enable bit in=20
> > drivers/net/wireless/ath/ath9k/reg.h
> > as under, may be we need to trun this on:-
> >
> > reg.h:1013:#define AR_PCIE_MSI                              0x4094
> > reg.h:1014:#define AR_PCIE_MSI_ENABLE                      =20
> 0x00000001
> >  =20
> According to ath9k developers adding MSI support to the=20
> driver is not trivial.
> They've tried once, it didn't work and they gave up. Any=20
> chance I can use mini-PCI-E slot without MSI ?

So, even after enabling the above bit, there were no MSI=20
interrupts from this card. If we look at some of the GbE=20
or SATA drivers, adding MSI is not that hard. ath9k can=20
be an exception.=20

I reported this issue to the p2020 board designer; but=20
unfortunately he is out until 1/4/10. It could be a missing=20
pull-up issue at IRQ0 or some thing else, I don't know.=20

>=20
> Thanks.
>=20
> Felix.

Thanks,
Vivek

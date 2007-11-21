Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F28FBDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 14:49:22 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lAL3n7qo014544
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 20:49:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAL3n6qE018809
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 21:49:06 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v7 3/9] add Freescale SerDes PHY support
Date: Wed, 21 Nov 2007 11:48:55 +0800
Message-ID: <989B956029373F45A0B8AF029708189001A1C7DF@zch01exm26.fsl.freescale.net>
In-Reply-To: <68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<fa686aa40710190835t4329d52bt74fb3b8f30b25847@mail.gmail.com>
	<68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
From: "Li Yang" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, November 21, 2007 11:32 AM
> To: Li Yang
> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org; Grant Likely
> Subject: Re: [PATCH v7 3/9] add Freescale SerDes PHY support
>=20
>=20
> On Oct 19, 2007, at 10:35 AM, Grant Likely wrote:
>=20
> > On 10/19/07, Li Yang <leoli@freescale.com> wrote:
> >> The SerDes(serializer/deserializer) PHY block is a new SoC=20
> block used=20
> >> in Freescale chips to support multiple serial interfaces,=20
> such as PCI=20
> >> Express, SGMII, SATA.
> >
> > This looks like board setup behaviour.  Shouldn't setting=20
> this up be=20
> > the responsibility firmware?  And failing that, I think it=20
> should be=20
> > done directly by the platform setup function (in other=20
> words; make it=20
> > a helper function and call it at board setup time). =20
> Besides, you want=20
> > to provide guarantees that the board is setup correctly before the=20
> > device driver that uses it gets probed.
> >
> > Cheers,
> > g.
>=20
> Upon further review of all this I don't think this belongs in=20
> the kernel at all.  This is one time setup and should be done=20
> in firmware.

I'm ok for it to be taken care of in u-boot for now.  However, if we
later plan to add power management support to this block.  We probably
have to do it in kernel.

- Leo

Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2890DDF5B
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 14:49:37 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAL3miA1004840
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 20:49:01 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lAL3mhBY021437
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 21:48:44 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v7 3/9] add Freescale SerDes PHY support
Date: Wed, 21 Nov 2007 11:48:42 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635D333A3@zch01exm21.fsl.freescale.net>
In-Reply-To: <68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com><1192793930-26039-2-git-send-email-leoli@freescale.com><1192793930-26039-3-git-send-email-leoli@freescale.com><1192793930-26039-4-git-send-email-leoli@freescale.com><fa686aa40710190835t4329d52bt74fb3b8f30b25847@mail.gmail.com>
	<68738B73-92D6-459F-88A7-BBE66967A3A0@kernel.crashing.org>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "Li Yang" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Oct 19, 2007, at 10:35 AM, Grant Likely wrote:
>=20
> > On 10/19/07, Li Yang <leoli@freescale.com> wrote:
> >> The SerDes(serializer/deserializer) PHY block is a new SoC=20
> block used
> >> in Freescale chips to support multiple serial interfaces,=20
> such as PCI
> >> Express, SGMII, SATA.
> >
> > This looks like board setup behaviour.  Shouldn't setting this up be
> > the responsibility firmware?  And failing that, I think it should be
> > done directly by the platform setup function (in other=20
> words; make it
> > a helper function and call it at board setup time). =20
> Besides, you want
> > to provide guarantees that the board is setup correctly before the
> > device driver that uses it gets probed.
> >
> > Cheers,
> > g.
>=20
> Upon further review of all this I don't think this belongs in the =20
> kernel at all.  This is one time setup and should be done in firmware.

The latest u-boot supports the serdes initialization for 837x.
So, it can be dropped from kernel for now.

Dave

Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2502567B56
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 13:27:53 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7V3RpOj025235
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 20:27:51 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7V3RnYa021659
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 22:27:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] corrected PCI interrupt sense values to level
	lowinmpc8349emds.dts
Date: Thu, 31 Aug 2006 11:28:18 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC9B2@zch01exm20.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263511BCA1@zch01exm21.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> <snip>
> >=20
> > > Where these IDSEL 0x15~0x18 come from on 8349EMDS board?
> > > Please expain it.
> >=20
> > This is from the docs on the PMC-PCI expansion boards that=20
> state what=20
> > IDSELs are used and how they are wired up.
>=20
> Maybe you misunderstand me, I know that, the IDSEL is=20
> determined by hardware design, I look up the schematic, only=20
> AD17/18/19 are connected to PCI SLOT, that is IDSEL=20
> 0x11~0x13, I cannot find the IDSEL 0x15~0x18 are impemented=20
> in the PIB. The IDSEL 0x15~0x18 actually are not existing.

These IDSELs are used by PCI Expansion Adaptor Board which has 4 PCI
slots for PCI1.

- Leo

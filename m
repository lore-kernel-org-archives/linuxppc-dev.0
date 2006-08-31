Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2DA4067B72
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 14:46:21 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7V65LS8013347
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 00:05:21 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7V4kH6f015479
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 23:46:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] corrected PCI interrupt sense values to level
	lowinmpc8349emds.dts
Date: Thu, 31 Aug 2006 12:46:16 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BCD9@zch01exm21.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC9B2@zch01exm20.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
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

> >=20
> > Maybe you misunderstand me, I know that, the IDSEL is determined by=20
> > hardware design, I look up the schematic, only
> > AD17/18/19 are connected to PCI SLOT, that is IDSEL 0x11~0x13, I=20
> > cannot find the IDSEL 0x15~0x18 are impemented in the PIB.=20
> The IDSEL=20
> > 0x15~0x18 actually are not existing.
>=20
> These IDSELs are used by PCI Expansion Adaptor Board which=20
> has 4 PCI slots for PCI1.

Oh...The PCI expansion adaptor board. I see.
I have not ever seen the board.

-DAve

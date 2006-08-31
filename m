Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E0F5F67B5C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 12:29:33 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7V3mXwD017520
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 21:48:33 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7V2TTFp028016
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 21:29:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] corrected PCI interrupt sense values to level low
	inmpc8349emds.dts
Date: Thu, 31 Aug 2006 10:29:27 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BCA1@zch01exm21.fsl.freescale.net>
In-Reply-To: <E8F8F71E-CEB8-4CEE-ACB7-AB602AB410BF@kernel.crashing.org>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<snip>
>=20
> > Where these IDSEL 0x15~0x18 come from on 8349EMDS board?
> > Please expain it.
>=20
> This is from the docs on the PMC-PCI expansion boards that=20
> state what IDSELs are used and how they are wired up.

Maybe you misunderstand me, I know that, the IDSEL is determined
by hardware design, I look up the schematic, only AD17/18/19 are
connected to PCI SLOT, that is IDSEL 0x11~0x13, I cannot find the
IDSEL 0x15~0x18 are impemented in the PIB. The IDSEL 0x15~0x18
actually are not existing.

-DAve

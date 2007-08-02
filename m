Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44B3EDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 11:17:31 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l721HOkV004228
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 18:17:25 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l721HL8P016173
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 20:17:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPCarchitecture
	with ULI chip quirk functions.
Date: Thu, 2 Aug 2007 09:17:20 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C74D58E@zch01exm26.fsl.freescale.net>
In-Reply-To: <1186005360.5495.529.camel@localhost.localdomain>
References: <11859560681182-git-send-email-wei.zhang@freescale.com>
	<11859560694083-git-send-email-wei.zhang@freescale.com>
	<1186005360.5495.529.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Ben,
=20
>=20
> Are we sure that any powerpc machine that uses that ULI chip will need
> the same quirk setting ?
>=20

We can ensure current platforms (as far as we know, MPC8544DS and
MPC8641HPCN) using ULI chips in powerpc of kernel need the same quirk
setting.
And we hope to make them more generic. And if there are some different
setting in the future, we can add special codes.

Thanks!
-zw

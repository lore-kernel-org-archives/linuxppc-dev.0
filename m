Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D144467B53
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 12:04:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7T3NEVa025947
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 21:23:14 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7T24Fm0001207
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 21:04:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [QUESTION] Enable coherency for all pages on 83xx to fix PCI data
	corruption
Date: Tue, 29 Aug 2006 10:04:14 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511B9EA@zch01exm21.fsl.freescale.net>
In-Reply-To: <4495EF77-BC25-45B9-AC7B-BFCEBC619510@kernel.crashing.org>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This was to address PCI5 if I remember correctly.
>=20
> - kumar
>=20
> On Aug 28, 2006, at 2:49 AM, Liu Dave-r63238 wrote:
>=20
> > All,
> >
> > I want to know which PCI errata is solved by this patch and if this=20
> > patch did test on real hardware.
> >
> > I know this patch turn on the 'M' bit -memory coherency.
> > But I don't believe this can solved the "PCI read multi-line"
> > errata.
> >
> > -DAve
<snip>

I also don't believe this patch can solve the PCI5 errata, The PCI5
description:

When external PCI devices try to read from the memory which is defined
as
prefetchable and where the transaction is more than one cache line,
there
may be data corruption.

-DAve

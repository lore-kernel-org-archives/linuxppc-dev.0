Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D87DFDDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 01:32:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 7/9] disallow building powermac and tsi108 without PCI
Date: Sun, 17 Jun 2007 17:32:03 +0200
References: <20070616000511.712667424@arndb.de>
	<20070616000618.965439750@arndb.de>
	<A9EC5456-63EF-4563-A175-ECFDE1B58912@kernel.crashing.org>
In-Reply-To: <A9EC5456-63EF-4563-A175-ECFDE1B58912@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706171732.04305.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 17 June 2007, Kumar Gala wrote:
> > @@ -31,6 +32,7 @@ config PPC_HOLLY
> > =A0=A0=A0=A0=A0=A0select TSI108_BRIDGE
> > =A0=A0=A0=A0=A0=A0select PPC_UDBG_16550
> > =A0=A0=A0=A0=A0=A0select CPU_7xx
> > +=A0=A0=A0=A0=A0select PCI
> > =A0=A0=A0=A0=A0=A0help
> > =A0=A0=A0=A0=A0=A0 =A0Select PPC_HOLLY if configuring for an IBM 750GX/=
CL Eval
> > =A0=A0=A0=A0=A0=A0 =A0Board with TSI108/9 bridge (Hickory/Holly)
>=20
> Any reason we just don't add the select to the config TSI108_BRIDGE =A0
> so any future TSI108 based systems get it as well?
>=20

Sounds good, I'll update the patch.

I also noticed that part of the TSI108 code appears to be written
so support !PCI configurations, so in theory it should be possible
fix up the problems with that. The reason I didn't was that it
ended up as quite a big number of changes that I couldn't properly
test.
The other question is of course whether it's useful to allow it.

	Arnd <><

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id B986ADDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 13:19:26 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3][POWERPC][V2] of_serial: Fix possible null dereference.
Date: Thu, 3 Apr 2008 04:18:29 +0200
References: <20080402165216.8FD2BC9807F@mail21-dub.bigfish.com>
	<200804030139.05497.arnd@arndb.de>
	<20080402195600.67b2eaf2@zod.rchland.ibm.com>
In-Reply-To: <20080402195600.67b2eaf2@zod.rchland.ibm.com>
MIME-Version: 1.0
Message-Id: <200804030418.29881.arnd@arndb.de>
Content-Type: text/plain;
  charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008, Josh Boyer wrote:
> > > > =C2=A0Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xil=
inx.com>
> > > > =C2=A0Signed-off-by: John Linn <john.linn@xilinx.com>
> > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >=20
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> This is the second time all three of us have Acked this. =C2=A0I'm pulling
> it in my tree.
>=20

Hehe, thanks!

I never know what the right thing to do with of_serial patches is.
In the past, I've sent them to akpm, in the absense of a dedicated
serial driver maintainer, but I'm just as happy when they get into
mainline any other way.

Of course, it feels a bit wrong for me to forward a patch that
was never sent to me personally.

	Arnd <><

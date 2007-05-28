Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 045B9DDF55
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 19:38:02 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4S9bvTE011253
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 02:37:57 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4S9bt0Q027482
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 04:37:56 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: fsl booke MM vs. SMP questions
Date: Mon, 28 May 2007 17:37:54 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263595EF6C@zch01exm21.fsl.freescale.net>
In-Reply-To: <1180344249.19517.74.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
	<1179889736.32247.893.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
	<1180344249.19517.74.camel@localhost.localdomain>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > I also noticed that tlb invalidation on the PowerPC 750 SMP system
> > is using the IPI mechanism, that is because the 750 can not=20
> > broadcast tlb invalidation ops.
>=20
> Do we support that in linux ?

Yes, it support in ppc, but not in powerpc arch. It may miss in the
powerpc when porting.

> Not really... it depends on bus traffic, plus the need to spinlock the
> broadcast tlbivax as well, etc..
>=20
> I'm not working on real HW at the moment. I don't know what the exact
> characteristics of your target HW are...

BTW, if the x86 processor support the broadcast tlb operation to system?
If it can,  why we adopt the IPI mechanism for x86? what is the concern?

-d

Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15874DDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 19:24:09 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m469O3Xd025394
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 02:24:04 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m469NpWX020347
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 04:24:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4] booting-without-of for Freescale MSI
Date: Tue, 6 May 2008 17:23:52 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C1399@zch01exm27.fsl.freescale.net>
In-Reply-To: <79f7e810cc79d5912587296c4f44b419@kernel.crashing.org>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-2-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-3-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-4-git-send-email-Jason.jin@freescale.com>
	<79f7e810cc79d5912587296c4f44b419@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
>=20
> > +    - compatible : should be "fsl,MPIC-MSI" for 85xx/86xx cpu,
> > +      and "fsl,IPIC-MSI" for 83xx cpu.
>=20
> Please use a more specific name, "fsl,8599-msi" or similar?
>

Thanks for your input. I think the name "fsl,MPIC-MSI" and
"fsl,IPIC-MSI"
is somethind specific. Actually, from the hardware point,  MSI is just
part
of MPIC of IPIC for Freescale CPU. the name "fsl,MPIC-MSI" can describe
the MSI is based on the MPIC controller.
=20
> > +    - interrupts : should contain the msi interrupts cascade to the
> > host
> > +      interrupt controller.
>=20
> You should describe that it is one "interrupts" entry per 32=20
> MSIs; also, it would be nice to say they need "0" as the sense.
>=20
> > +    - interrupt-parent: should be "&mpic" for 85xx/86xx cpu and
> > "&ipic"
> > +      for 83xx cpu.
>=20
> &Xpic are labels, so something local to specific DTS files;=20
> instead, say that the interrupts are routed to the MPIC/IPIC=20
> (it doesn't have to be via "interrupt-parent", either).
>=20
Thank you, I'll rewrite these description.=20


> Segher
>=20
> p.s. On a meta-note, please put the binding doc first in the=20
> series, it makes things easier to review in-order.

Ok, I'll put it first next time.

Jason

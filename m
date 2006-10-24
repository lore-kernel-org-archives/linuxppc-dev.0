Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 17960679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 17:16:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k9O7UFg7013511
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 00:30:15 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9O7GgTt009998
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 02:16:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Tue, 24 Oct 2006 15:17:27 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D2071C2@zch01exm20.fsl.freescale.net>
In-Reply-To: <453D097D.6090603@freescale.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
> Sent: Tuesday, October 24, 2006 2:27 AM
> To: Segher Boessenkool
> Cc: mrz5149@acm.org; Li Yang-r58472; Paul Mackerras;
linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
>=20
> Segher Boessenkool wrote:
> > If a sync after an MMIO write is enough, then (in almost all
> > cases) so is an eieio.
>=20
> In this case, the spurious interrupts still happen with eieio, but not
> with sync. =20

eieio on e300 core is just a no-op.

- Leo

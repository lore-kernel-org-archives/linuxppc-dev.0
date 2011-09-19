Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC56FB6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Sep 2011 10:20:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] RapidIO: documentation update
Date: Sun, 18 Sep 2011 17:20:38 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552021F93AE@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4E7470E6.2000404@neli.hopto.org>
References: <1316092759-5460-1-git-send-email-alexandre.bounine@idt.com>
	<4E7470E6.2000404@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Micha Nelissen <micha@neli.hopto.org>
Cc: Liu Gang <Gang.Liu@freescale.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
>=20
> Alexandre Bounine wrote:
> >  After the host has completed enumeration of the entire network it
releases
> >  devices by clearing device ID locks (calls rio_clear_locks()). For
each endpoint
> > -in the system, it sets the Master Enable bit in the Port General
Control CSR
> > +in the system, it sets the Discovered bit in the Port General
Control CSR
> >  to indicate that enumeration is completed and agents are allowed to
execute
> >  passive discovery of the network.
>=20
> The host needs to set both. Without Master Enable an agent is not
> supposed to initiate transactions on the "bus", that's the meaning of
> that bit.

This is correct and host set both bits: Master_Enable and Discovered.
The documentation change above is related to event that triggers
discovery process.
In this context the change shown above is sufficient.
Please see the original code patch submitted by Liu Gang.

Alex.
  =20

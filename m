Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C4B9DE04B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 12:15:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4N2Fr55011061
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 19:15:54 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4N2Fqhh016423
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 21:15:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2] [POWERPC] mpic: deal with bogus NIRQ in
	FeatureReporting Register
Date: Fri, 23 May 2008 10:15:50 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A915AB8@zch01exm27.fsl.freescale.net>
In-Reply-To: <1211403708.8297.251.camel@pasglop>
References: <Pine.LNX.4.64.0805211559110.31758@blarg.am.freescale.net>
	<1211403708.8297.251.camel@pasglop>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,

So I should  change the MSI hwirq num according to this change, The
patches
will be send after this changes updated to your tree. How about applying
the MSI=20
driver firstly?

Jason

> -----Original Message-----
> From: linuxppc-dev-bounces+jinzhengxiong=3Dgmail.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+jinzhengxiong=3Dgmail.com@ozlabs.or
> g] On Behalf Of Benjamin Herrenschmidt
> Sent: Thursday, May 22, 2008 5:02 AM
> To: Kumar Gala
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v2] [POWERPC] mpic: deal with bogus NIRQ=20
> in FeatureReporting Register
>=20
>=20
> On Wed, 2008-05-21 at 15:59 -0500, Kumar Gala wrote:
> > Some chips (like the SoCs from Freescale) report the wrong value in=20
> > NIRQ and this causes issues if its doesn't match or exceed=20
> the value=20
> > of irq_count.
> >=20
> > Add a flag that board code can set to just use irq_count instead of=20
> > FRR[NIRQ].  Eventually we'll add a device tree property with the=20
> > number of sources.
> >=20
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20

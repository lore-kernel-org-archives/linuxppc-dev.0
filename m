Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94D4DDF11C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 00:39:52 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5QEdkNT023660
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 07:39:47 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m5QEdicG019672
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 09:39:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] mpc83xx: Power Management support
Date: Thu, 26 Jun 2008 22:39:41 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC201011622@zch01exm21.fsl.freescale.net>
In-Reply-To: <D70F79B4-BA5F-46D4-9D74-4CB2E375AF60@kernel.crashing.org>
References: <20080625215051.GA11784@loki.buserror.net>
	<D70F79B4-BA5F-46D4-9D74-4CB2E375AF60@kernel.crashing.org>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Wood Scott" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Basic PM support for 83xx.  Standby is implemented as sleep.
> > Suspend-to-RAM is implemented as "deep sleep" (with the processor
> > turned off) on 831x.  PCI agent power management is supported.
> >
> > Device power management of SOC peripherals is not yet supported.
>=20
> (Not comments on this patch, but related)
>=20
> Do you know if anyone is looking at making sure DOZE/NAP work on =20
> 83xx?  We clearly don't flush the L1 cache today in the 6xx code.

I did the test on 837x, the NAP did *not* work, due to the cache
coherence issue.
You are right, currently no flush L1 in the 6xx code, maybe it depend on
the
platform hardware capability.

Dave

Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 43001DDEC4
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 21:04:08 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAUA408r025333
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 03:04:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAUA3xLu014266
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 04:03:59 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v7 7/9] ipic: clean up unsupported ack operations
Date: Fri, 30 Nov 2007 18:03:59 +0800
Message-ID: <989B956029373F45A0B8AF029708189001A1CE7B@zch01exm26.fsl.freescale.net>
In-Reply-To: <0BCAE755-0506-405D-BFCA-94C2261CBE30@kernel.crashing.org>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
	<1192793930-26039-7-git-send-email-leoli@freescale.com>
	<1192793930-26039-8-git-send-email-leoli@freescale.com>
	<0BCAE755-0506-405D-BFCA-94C2261CBE30@kernel.crashing.org>
From: "Li Yang" <LeoLi@freescale.com>
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

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, November 30, 2007 8:36 AM
> To: Li Yang
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v7 7/9] ipic: clean up unsupported ack operations
>=20
>=20
> On Oct 19, 2007, at 6:38 AM, Li Yang wrote:
>=20
> > IPIC controller doesn't support ack operations.  The=20
> pending registers=20
> > are read-only.  The patch removes ack operations which are=20
> not needed.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/sysdev/ipic.c |   40 +=20
> > +--------------------------------------
> > 1 files changed, 2 insertions(+), 38 deletions(-)
>=20
> applied.

Hi Kumar,

Please hold on this one.  Actually external interrupts in edge mode need
this ack operation.  But in most cases (level triggered) ack is not
needed.  I will provide an updated patch later on to take care both
trigger modes.  Thanks.

- Leo

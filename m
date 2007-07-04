Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C190ADDE9E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 15:33:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l645XiQp029725
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 22:33:44 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l645XgAx000722
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 00:33:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2.6.23] 83xx USB platform code rework
Date: Wed, 4 Jul 2007 13:35:38 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D83910@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070704141514.cc77369f.sfr@canb.auug.org.au>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Wednesday, July 04, 2007 12:15 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; galak@kernel.crashing.org;
linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2.6.23] 83xx USB platform code rework
>=20
> Hi Li,
>=20
> On Tue,  3 Jul 2007 17:43:16 +0800 Li Yang <leoli@freescale.com>
wrote:
> >
> > Add 831x USB platform setup code and rework 834x USB
> > platform setup code.  Move USB platform code to usb.c
> > for different boards with CPU of the same series to share
> > the USB initialization code.
>=20
> If there really is a part of this that is just code movement, then
that
> should be split out into a separate patch.  It makes the reviewers job
so
> much easier.

Actually, it is not pure code movement.  The code has been re-written.

- Leo

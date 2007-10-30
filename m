Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E5F3DE1CC
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 19:40:47 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9U8e355020534
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 01:40:11 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9U8e1sp003264
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 03:40:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/5 v3] Porting RapidIO driver from ppc to powerpc
	architecture and adding memory mapped RapidIO driver.
Date: Tue, 30 Oct 2007 16:40:06 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C90B3DB@zch01exm26.fsl.freescale.net>
In-Reply-To: <B485F0BB-A5C5-4059-8BE1-7020701EB818@kernel.crashing.org>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<1193686720.20377.2.camel@pterry-fc6.micromemory.com>
	<B485F0BB-A5C5-4059-8BE1-7020701EB818@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <pterry@micromemory.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, I'm working on it. Do not worry about it.

Wei.=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Tuesday, October 30, 2007 4:31 AM
> To: pterry@micromemory.com
> Cc: Zhang Wei-r63237; mporter@kernel.crashing.org;=20
> paulus@samba.org; linuxppc-dev@ozlabs.org;=20
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/5 v3] Porting RapidIO driver from ppc=20
> to powerpc architecture and adding memory mapped RapidIO driver.
>=20
>=20
> On Oct 29, 2007, at 2:38 PM, Phil Terry wrote:
>=20
> > Can anyone tell me what the status of these are? What kernel =20
> > release are
> > they targetted for? Currently I'm trying to work with 2.6.23 plus =20
> > these
> > patches locally.
>=20
> hopefully 2.6.25.  I'd like to get the documentation updates in =20
> 2.6.24 if we have agreement on them.
>=20
> - k
>=20

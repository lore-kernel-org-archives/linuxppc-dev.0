Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 323F3DDFF3
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 13:29:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3I3TGtE015350
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 20:29:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3I3TEp8007463
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:29:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch to the cpm_muram
	implementation
Date: Fri, 18 Apr 2008 11:29:12 +0800
Message-ID: <989B956029373F45A0B8AF029708189002007624@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080417141043.GA21793@ld0162-tx32.am.freescale.net>
References: <20080416182214.GA20056@polina.dev.rtsoft.ru>
	<989B956029373F45A0B8AF02970818900200750D@zch01exm26.fsl.freescale.net>
	<20080417141043.GA21793@ld0162-tx32.am.freescale.net>
From: "Li Yang" <LeoLi@freescale.com>
To: "Wood Scott" <scottwood@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jgarzik@pobox.com>, Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott=20
> Sent: Thursday, April 17, 2008 10:11 PM
> To: Li Yang
> Cc: avorontsov@ru.mvista.com; Kumar Gala;=20
> linuxppc-dev@ozlabs.org; Jeff Garzik; Tabi Timur;=20
> netdev@vger.kernel.org
> Subject: Re: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch=20
> to the cpm_muram implementation
>=20
> On Wed, Apr 16, 2008 at 08:38:19PM -0700, Li Yang wrote:
> > It is a good thing to unify the CPM dpram operation and QE muram=20
> > operation.  But I'm having concerns about the naming as CPM is an=20
> > obsolete block.  Can we change to use the new name QE instead?
>=20
> And then change it again when marketing decides that CPM4=20
> will be called something other than QE2? :-P

It's a good point. :)  Technically they are quite similar.  But they are
not so well known as Pentium to x86.  The change will cause confusion
especially when both of the terms of CPM and QE are used in one file.  I
agree with Kumar's suggestion that we keep both names.

- Leo

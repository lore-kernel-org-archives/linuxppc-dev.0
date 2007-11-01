Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCE24DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 13:33:31 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lA12XPIV019183
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 19:33:26 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA12XOkN010127
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 21:33:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ucc_geth: add support for netpoll
Date: Thu, 1 Nov 2007 10:33:24 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B642A@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071031215903.GA1287@zarina>
References: <20071011124842.GB13963@localhost.localdomain>
	<4723389F.7010109@ru.mvista.com> <20071027143731.GA2616@zarina>
	<989B956029373F45A0B8AF0297081890019B61BF@zch01exm26.fsl.freescale.net>
	<20071029121744.GA20372@localhost.localdomain>
	<20071031215903.GA1287@zarina>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <cbou@mail.ru>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Anton Vorontsov [mailto:cbou@mail.ru]=20
> Sent: Thursday, November 01, 2007 5:59 AM
> To: Li Yang-r58472
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] ucc_geth: add support for netpoll
>=20
> On Mon, Oct 29, 2007 at 03:17:44PM +0300, Anton Vorontsov wrote:
> [...]
> > > Oops.  The original patch happened to hit the Junk mail box. :(
> >=20
> > That one as well? http://lkml.org/lkml/2007/10/11/128
> >=20
> > > I think
> > > the patch is good to merge after the cosmetic change.  I=20
> can do it=20
> > > in next pull request to Jeff.
> >=20
> > Ok, great. Thanks.
>=20
> I'm wondering if you missed that email again. Maybe your mail=20
> client/server doing weird things with emails from @ru.mvista.com?

No.  I have explicitly add you to the whitelist. :) Please be patient,
isn't this patch a new feature which can only be integrated in the merge
window?  Thanks.

- Leo

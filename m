Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 82064B6F06
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 13:12:15 +1000 (EST)
Received: from mail28-tx2 (localhost.localdomain [127.0.0.1])	by
	mail28-tx2-R.bigfish.com (Postfix) with ESMTP id A0DD1AA8334	for
	<linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 02:57:07 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.240])	by
	mail28-tx2.bigfish.com (Postfix) with ESMTP id 6076F6A804E	for
	<linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 02:57:07 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o742v3r2006449	for <linuxppc-dev@ozlabs.org>;
	Tue, 3 Aug 2010 19:57:03 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o742v8MR022879	for <linuxppc-dev@ozlabs.org>;
	Tue, 3 Aug 2010 21:57:08 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Wed, 4 Aug 2010 10:57:00 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A07EFE1@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100803164346.69a63557.akpm@linux-foundation.org>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org]=20
> Sent: Wednesday, August 04, 2010 7:44 AM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> On Tue, 3 Aug 2010 11:11:10 +0800
> Roy Zang <tie-fei.zang@freescale.com> wrote:
>=20
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> >  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> >  /* Controller cannot support End Attribute in NOP ADMA=20
> descriptor */
> >  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> > +/* Controller uses Auto CMD12 command to stop the transfer */
> > +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
>=20
> This becomes 1<<29 in my tree.
It also works.
>=20
> We're about to run out. =20
:-(
>What happens then?
Rewrite the code to extend some bits, I suppose.
Roy

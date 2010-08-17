Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id A564CB70A7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 16:48:57 +1000 (EST)
Received: from mail92-tx2 (localhost.localdomain [127.0.0.1])	by
	mail92-tx2-R.bigfish.com (Postfix) with ESMTP id 62A30240181	for
	<linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 06:48:53 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.241])	by
	mail92-tx2.bigfish.com (Postfix) with ESMTP id 2C2CB9C804E	for
	<linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 06:48:53 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7H6mXhR004515	for <linuxppc-dev@ozlabs.org>;
	Mon, 16 Aug 2010 23:48:43 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7H70F3o026756	for <linuxppc-dev@ozlabs.org>;
	Tue, 17 Aug 2010 02:00:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
Date: Tue, 17 Aug 2010 14:48:28 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A07C66F@zch01exm23.fsl.freescale.net>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A056400@zch01exm23.fsl.freescale.net>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Zang Roy-R61911" <R61911@freescale.com>, <akpm@linux-foundation.org>,
	<linux-mmc@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org, mirqus@gmail.com
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
> From: Zang Roy-R61911=20
> Sent: Wednesday, August 11, 2010 12:47 PM
> To: Zang Roy-R61911; akpm@linux-foundation.org;=20
> linux-mmc@vger.kernel.org
> Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com;=20
> cbouatmailru@gmail.com; grant.likely@secretlab.ca
> Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for=20
> more clear
>=20
> =20
>=20
> > -----Original Message-----
> > From: Zang Roy-R61911=20
> > Sent: Tuesday, August 10, 2010 17:47 PM
> > To: akpm@linux-foundation.org; linux-mmc@vger.kernel.org
> > Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com;=20
> > cbouatmailru@gmail.com; grant.likely@secretlab.ca
> > Subject: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
> >=20
> > Change ACMD12 to AUTO_CMD12 to reduce the confusion.
> > ACMD12 might be confused with MMC/SD App CMD 12 (CMD55+CMD12 combo).
> >=20
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-of-core.c |    2 +-
> >  drivers/mmc/host/sdhci.c         |    8 ++++----
> >  drivers/mmc/host/sdhci.h         |   10 +++++-----
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> Andrew,=20
> Could you help to pick up this minor fix?
> Thanks.
> Roy
Any update on these two patches?
Thanks.
Roy

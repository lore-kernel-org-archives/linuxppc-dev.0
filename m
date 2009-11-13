Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 960B9B7B91
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 19:30:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAD8U3cB027898
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 01:30:03 -0700 (MST)
Received: from zmy16exm21.fsl.freescale.net (zmy16exm21.ap.freescale.net
	[10.211.3.25])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAD8XO1C001233
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 02:33:25 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
Date: Fri, 13 Nov 2009 16:30:13 +0800
Message-ID: <CF6163088BDE8747873ADAA4AF922BF2923E04@zmy16exm21.fsl.freescale.net>
In-Reply-To: <56F6ACCC-7FE8-44E6-BF5E-6361997F524F@kernel.crashing.org>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<20090923115518.GB6425@oksana.dev.rtsoft.ru>
	<CF6163088BDE8747873ADAA4AF922BF287EDB0@zmy16exm21.fsl.freescale.net>
	<56F6ACCC-7FE8-44E6-BF5E-6361997F524F@kernel.crashing.org>
From: "Gao Guanhua-B22826" <B22826@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Kumar,

I tried to update the patch based on the latest kernel tree
(2.6.32-rc6), there are some problems:
1) the P2020DS board has supported SDHC using DMA, and the latest kernel
tree has included the related code, it doesn't need most of the patches
I posted before.
2) I compiled the image, but the SDHC can not work, it reports error
-110. I adjusted the timeout to the max value, but anther error
occurred.



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, November 05, 2009 9:52 PM
> To: Gao Guanhua-B22826
> Cc: avorontsov@ru.mvista.com; linuxppc-dev@ozlabs.org;=20
> sdhci-devel@lists.ossman.eu
> Subject: Re: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
>=20
>=20
> On Sep 24, 2009, at 3:28 AM, Gao Guanhua-B22826 wrote:
>=20
> > Thanks, I will add them.
> >
> >> -----Original Message-----
> >> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]
> >> Sent: Wednesday, September 23, 2009 7:55 PM
> >> To: Gao Guanhua-B22826
> >> Cc: sdhci-devel@lists.ossman.eu; linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
> >>
> >> On Wed, Sep 23, 2009 at 05:08:09PM +0800, Gao Guanhua wrote:
> >>> The SDHC can not work on DMA mode because of the hardware
> >> bug, so we
> >>> set a broken dma flag and use PIO mode. This patch applies
> >> to Rev1.0.
> >>
> >> Signed-off-by line is missing (in all patches).
> >
>=20
> Any plan to update & repost these patches?
>=20
> - k
>=20
>=20

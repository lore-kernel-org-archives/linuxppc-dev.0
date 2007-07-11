Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95E65DDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 17:40:07 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6B7e1kE013508
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:40:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6B7e0kw007157
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:40:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 3/4] Extend the DMA-engine API.
Date: Wed, 11 Jul 2007 15:39:58 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3CED@zch01exm26.fsl.freescale.net>
In-Reply-To: <e9c3a7c20707101141m17e313e2k99be5b7197edc910@mail.gmail.com>
References: <11840607111926-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20707101141m17e313e2k99be5b7197edc910@mail.gmail.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Dan,=20

Do you mention here: =
http://marc.info/?l=3Dlinux-raid&m=3D118290909614463&w=3D2 ?
I see the async_tx is located at crypto/ of the above page, but my patch =
is for DMA engine in drivers/dma and for DMA engine driver.

Thanks!
Wei.
> -----Original Message-----
> Subject: Re: [PATCH 3/4] Extend the DMA-engine API.
>=20
> On 7/10/07, Zhang Wei <wei.zhang@freescale.com> wrote:
> > Add channel wait queue and transfer callback dma_xfer_callback().
> > If the DMA controller and driver support interrupt, when the
> > transfer is finished, it will wakeup the wait queue
> > and call the callback function of the channel.
> >
> > Add dma_async_raw_xfer() to API and device_raw_xfer() to=20
> struct dma_device
> > for RAW physical address DMA transfer, which will be used=20
> at transfer
> > between I/O address and memory address.
> >
>=20
> Please review the async_tx API patch series[1], it should meet your
> needs.  What you call "raw" mode support is now default for the
> dmaengine driver interface.  I plan to request that this series be
> merged for 2.6.23.
>=20
> Regards,
> Dan
>=20
> [1]http://marc.info/?l=3Dlinux-raid&w=3D2&r=3D1&s=3Dmd-accel&q=3Db
>=20
